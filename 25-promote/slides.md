%titles Postgresql
%author: xavki


# Réplication : test


<br>
* création d'une db sur le slave = rejet
* création d'une db sur le master = ok = réplication

<br>
* une table système permet de vérifier l'état de la réplication

```
\x
SELECT * FROM PG_STAT_REPLICATION;
```

Permet de voir la latence si il y en a une grâce au wal

* test d'arrêt du master = rien (prochaines vidéos) => failover manuel

-----------------------------------------------------------------------

# Réplication : failover manuel


* promotion d'un slave en master

```
cat /var/lib/postgresql/11/main/recovery.conf 
standby_mode = 'on'
primary_conninfo = 'host=192.168.60.4 port=5432 user=replication password=replication'
trigger_file = '/tmp/MasterNow' # ce fichier coupe la réplication et promeut le slave
```

* trigger file : déclencheur de la progression

```
touch /tmp/MasterNow
```

Attention : test du master et du slave (désynchronisation)

------------------------------------------------------------------------

# Réplication : resynchronisation de l'ancien master


<br>
* suppression des datas du slave

```
service postgresql stop
rm -rf /var/lib/postgresql/11/main/*
```

<br>
* synchroniser en tant que postgres

```
pg_basebackup -h 192.168.60.4 -D /var/lib/postgresql/11/main/ -P -U replication --wal-method=fetch
```

<br>
* créer un fichier recovery.conf en tant que postgres

```
vim var/lib/postgresql/11/main/recovery.conf
standby_mode = 'on'
primary_conninfo = 'host=192.168.60.4 port=5432 user=replication password=replication'
trigger_file = '/tmp/MasterNow' # ce fichier coupe la réplication et promeut le slave
```

