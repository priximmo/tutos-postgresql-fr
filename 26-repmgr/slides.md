%titles Postgresql
%author: xavki


# Replication Manager - REPMGR


<br>
* outil de gestion de la réplication

* CLI simple pour réaliser les actions

* utilise la réplication par slot



-------------------------------------------------------------------

# Installation  REPMGR / Réplication

<br>
* installation du paquet

```
apt-get install postgresql-11-repmgr
```

<br>
Adapatation de la configuration de postgres

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
* adaptation du pg_hba

```
local   all             postgres                                peer
local   all             all                                     peer
host    repmgr          repmgr          192.168.57.xx/24        trust
host    replication     repmgr          192.168.57.xx/24        trust
host    replication     repmgr          127.0.0.1/32            trust
host    repmgr          repmgr          127.0.0.1/32            trust
host    replication     repmgr          127.1.0.1/32            trust
host    repmgr          repmgr          127.1.0.1/32            trust
host    all             all             0.0.0.0/0            md5

```

* création de la database repmgr

```
createdb repmgr -O repmgr
```

Rq : owner repmgr


--------------------------------------------------------------------


# Installation  REPMGR / Réplication


<br>
* accès ssh croisés aux users postgres

```
ssh-keygen
mkdir /var/lib/postgresql/.ssh
chmod 700 /var/lib/postgresql/.ssh
chown postgres:postgres /var/lib/postgresql/.ssh
```

* copie de la clef publique (attention aux droits 0644)

* amorçage des fichiers de logs

```
touch /var/log/postgresql/repmgrd.log
```


--------------------------------------------------------------------
