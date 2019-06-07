title: Postgresql
author: xavki


# Installation


<br>
Sur Debian

```
apt-get install portgresql<version>-server
```



<br>
Gestion via système D

```
service postgresql status
service postgresql stop
service postgresql start
service postgresql reload
```

-------------------------------------------------------------------


# Principaux répertoires

<br>
* configuration : /etc/postgresql/<version>/<clusterpg>

<br>
* datas : /var/lib/postgresql/<version>/<clusterpg> 

<br>
* binaire principal : /usr/lib/postgresql/10/bin/postgres

<br>
* binaires : /usr/bin/ (pg_*)


<br>
# Processus forkés


```
postgres -D /var/lib/postgresql/10/main -c config_file=/etc/postgresql/10/main/postgresql.conf
  \_ postgres: 10/main: checkpointer process   
  \_ postgres: 10/main: writer process   
  \_ postgres: 10/main: wal writer process   
  \_ postgres: 10/main: autovacuum launcher process   
  \_ postgres: 10/main: stats collector process   
  \_ postgres: 10/main: bgworker: logical replication launcher 
```

