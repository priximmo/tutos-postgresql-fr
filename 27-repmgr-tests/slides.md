%titles Postgresql
%author: xavki


# Replication Manager - REPMGR


<br>
* outil de gestion de la réplication

* CLI simple pour réaliser les actions

* utilise la réplication par slot

<br>
* génération et échange des clefs ssh sur chaque machine

```
ssh-keygen
cat .ssh/id_rsa.pub
vim .ssh/authorized_keys
```



-------------------------------------------------------------------

# Installation  REPMGR / Réplication

<br>
* installation du paquet

```
apt-get install -y postgresql-11-repmgr
```

<br>
Adaptation de la configuration de postgres

* include d'un fichier dans le postgresql.conf

```
include 'postgresql.replication.conf'
```

* fichier postgresql.replication.conf

```
max_wal_senders = 15
max_replication_slots = 15
wal_level = 'replica'
hot_standby = on
#archive_mode = on
wal_keep_segments = 500
shared_preload_libraries= 'repmgr'
```

-------------------------------------------------------------------

# Installation  REPMGR / Réplication


<br>
* création du user "repmgr" avec les droits REPLICATION

```
createuser --replication --createdb --createrole --superuser repmgr
```

<br>
* adaptation du pg_hba.conf

```
local   all             postgres                                peer
local   all             all                                     peer
host    repmgr          repmgr          192.168.60.1/24        trust
host    replication     repmgr          192.168.60.1/24        trust
host    replication     repmgr          127.0.0.1/32            trust
host    repmgr          repmgr          127.0.0.1/32            trust
host    replication     repmgr          127.1.0.1/32            trust
host    repmgr          repmgr          127.1.0.1/32            trust
host    all             all             0.0.0.0/0            md5

service postgresql restart
```

* création de la database repmgr

```
createdb repmgr -O repmgr
```

Rq : owner repmgr

--------------------------------------------------------------------

# REPMGR : installation

* configuration de repmgr

```
mkdir /etc/repmgr
vim /etc/repmgr/repmgr.conf
```

```
node_id=<ip-address>
node_name=<hostname>
conninfo='host=<hostname> user=repmgr dbname=repmgr connect_timeout=0.1'
data_directory='/var/lib/postgresql/11/main'
use_replication_slots=yes
monitoring_history=yes
reconnect_attempts=1
reconnect_interval=1
service_start_command   = 'sudo /usr/bin/pg_ctlcluster 11 main start'
service_stop_command    = 'sudo /usr/bin/pg_ctlcluster 11 main stop'
service_restart_command = 'sudo /usr/bin/pg_ctlcluster 11 main restart'
service_reload_command  = 'sudo /usr/bin/pg_ctlcluster 11 main reload'
service_promote_command = 'sudo /usr/bin/pg_ctlcluster 11 main promote'
promote_check_timeout = 15
failover=automatic
promote_command='/usr/bin/repmgr standby promote -f /etc/repmgr/repmgr.conf --log-to-file'
follow_command='/usr/bin/repmgr standby follow -f /etc/repmgr/repmgr.conf --log-to-file --upstream-node-id=%n'
log_file='/var/log/postgresql/repmgr.log'
```

--------------------------------------------------------------------

# REPMGR : conf daemon

* édition du fichier /etc/default/repmgrd

```
REPMGRD_ENABLED=yes
REPMGRD_CONF="/etc/repmgr/repmgr.conf"
REPMGRD_OPTS="--daemonize=false"
REPMGRD_USER=postgres
REPMGRD_BIN=/usr/bin/repmgrd
REPMGRD_PIDFILE=/var/run/repmgrd.pid
```

<br>
* sur le master

```
service repmgrd start
service postgresql restart
```

--------------------------------------------------------------------

# REPMGR : activation de repmgr

<br>
* vérification du cluster sur le master

```
repmgr cluster show
repmgr primary register --force
```

<br>
* sur le slave : synchronisation des datas

```
service postgresql stop
rm -rf /var/lib/postgresql/11/main
repmgr -h <ip-master> -U repmgr -d repmgr standby clone
```

* enregistrement du slave

```
repmgr standby register
repmgr cluster show
```


