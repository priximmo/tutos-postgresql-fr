%titles Postgresql
%author: xavki


# Replication


<br>
* meilleure documentation : 
https://public.dalibo.com/exports/formation/manuels/formations/dba3/dba3.handout.pdf

* réplication et la gestion du failover (perte d'un noeud et repise de l'activité par le second)

<br>
* réplications :
		* physique : à partir des fichiers de jounaux de transactions wal
		* logique : abonnements à des slots de l'éditeur/master (version >=10) 

<br>
* symétrique/asynchrone : 
					* le fait de pouvoir avoir plusieurs maitres (écriture/lecture)
					* écriture sur slave différée = perte de données possible en cas de crash

* asymétrique/synchrone :
					* un master (slave en lecture - Hot StandBy contrairement Warm Standy)
					* écriture sans délais sur le slave (écriture plus longue car aller/retour)

* symétrique/synchrone

<br>
* 2 types de transmission :
		* log shipping : envoi des fichiers de journaux 
			* attention : fréquence des journaux et leurs paramètres (archive_timeout)
		* streaming réplication : groupes d'enregistrement par flux (plus petits donc plus fréquents)
			* souvent en Hot Standby

------------------------------------------------------------------------------------------------------


# Réplication : Master


<br>
Création du user dédié à la réplication 

* Vérifier / compléter le pg_hba.conf pour le user et la DB replcation :

```
host    replication     replication     192.168.60.0/24         md5
```

<br>
* Création du user replication avec l'option REPLICATION

```
CREATE USER replication REPLICATION LOGIN CONNECTION LIMIT 1 ENCRYPTED PASSWORD 'replication';
```

<br>
* configuration de postgresql.conf :

```
listen_addresses = '*'
wal_level = replica
max_wal_senders = 10
wal_keep_segments = 100 			# nb de fichier wal conservé (100 x 16M = 1,6G)
hot_standby = on
```

------------------------------------------------------------------------------------------------------

# Réplication : Slave


<br>
* stopper postgresql sur le slave

```
service postgresql stop
```

<br>
* Vérifier / compléter le pg_hba.conf

```
host    replication     replication     192.168.60.0/24         md5
```

<br>
* adapter le postgresql.cof

```
wal_level = replica
max_wal_senders = 10
wal_keep_segments = 100
listen_addresses = '*'
hot_standby = on
```

<br>
* suppression des datas du slave

```
rm -rf /var/lib/postgresql/11/main/*
```

<br>
* synchroniser en tant que postgres

```
pg_basebackup -h 192.168.60.3 -D /var/lib/postgresql/11/main/ -P -U replication --wal-method=fetch
```

<br>
* créer un fichier recovery.conf en tant que postgres

```
vim var/lib/postgresql/11/main/recovery.conf 
standby_mode = 'on'
primary_conninfo = 'host=192.168.60.3 port=5432 user=replication password=replication'
trigger_file = '/tmp/MasterNow' # ce fichier coupe la réplication et promeut le slave
```
