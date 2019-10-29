%titles Postgresql
%author: xavki


# Replication Manager - REPMGR


<br>
* outil de gestion de la réplication

* CLI simple pour réaliser les actions

* 2 outils en un :
		* repmgr : CLI d'administration
		* repmgrd : daemon supervise et réalise le failover (bascule M/S)


-------------------------------------------------------------------

# Installation  REPMGR / Réplication

<br>
* installation du paquet

```
apt-get install -y postgresql-11-repmgr
```

* génération et échange des clefs ssh sur chaque machine

```
ssh-keygen
cat .ssh/id_rsa.pub
vim .ssh/authorized_keys
```

<br>
Adaptation de la configuration de postgres

* fichier postgresql.replication.conf

```
listen_addresses = '*'
max_wal_senders = 15
max_replication_slots = 15
wal_level = 'replica'
hot_standby = on
wal_keep_segments = 100
shared_preload_libraries = 'repmgr'
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
host    all             all             0.0.0.0/0            md5
```

<br>
* création de la database repmgr

```
service postgresql restart
createdb repmgr -O repmgr
```

--------------------------------------------------------------------

# REPMGR : installation

<br>
* configuration de repmgr

```
vim /etc/repmgr.conf
```

```
node_id=1
node_name=192.168.60.3
conninfo='host=192.168.60.3 user=repmgr dbname=repmgr connect_timeout=0.1'
data_directory='/var/lib/postgresql/11/main'
use_replication_slots=yes
monitoring_history=yes
reconnect_attempts=1
reconnect_interval=1
service_start_command   = '/usr/bin/pg_ctlcluster 11 main start'
service_stop_command    = '/usr/bin/pg_ctlcluster 11 main stop'
service_restart_command = '/usr/bin/pg_ctlcluster 11 main restart'
service_reload_command  = '/usr/bin/pg_ctlcluster 11 main reload'
service_promote_command = '/usr/bin/pg_ctlcluster 11 main promote'
promote_check_timeout = 15
failover=automatic
promote_command='/usr/bin/repmgr standby promote -f /etc/repmgr.conf --log-to-file'
follow_command='/usr/bin/repmgr standby follow -f /etc/repmgr.conf --log-to-file --upstream-node-id=%n'
log_file='/var/log/postgresql/repmgr.log'
```

--------------------------------------------------------------------

# REPMGR : configuration du daemon

<br>
* édition du fichier /etc/default/repmgrd

```
REPMGRD_ENABLED=yes
REPMGRD_CONF="/etc/repmgr.conf"
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
service postgresql start
```

* enregistrement du slave

```
repmgr standby register
repmgr cluster show
```


