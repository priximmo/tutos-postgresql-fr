%titles Postgresql
%author: xavki


# REPMGR - gestion et resynchronisation


<br>
* commandes en tant que postgres

* état du cluster

```
repmgr cluster show
```

* table d'état de la réplication

```
# sur le slave
select * from pg_stat_wal_receiver;
# sur le master
select * from pg_stat_replication;
```

-------------------------------------------------------------

# REPMGR - resynchronisation


<br>
* stop du master

```
service postgresql stop
```

<br>
* suppression des datas de l'ancien master

```
rm -rf /var/lib/postgresql/11/main/
```

<br>
* resynchronisation de l'ancien master

```
repmgr -h <slave> -U repmgr -d repmgr --copy-external-config-files standby clone
```

Rq :copie des fichiers de configurations

<br>
* redémarrage de postgres et enregistrement en tant que nouveau slave

```
repmgr standby register --force
```

<br>
* ne pas oublier de restarter repmgr

```
service repmgrd restart
repmgr cluster show
```

<br>
* idéal scripter en complétant les bonnes ip/noms au cas où
		* moins de doute sur le moment
