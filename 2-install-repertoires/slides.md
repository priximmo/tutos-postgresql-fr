title: Postgresql
author: xavki


# Installation


<br>
Sur Debian

```
apt-get install postgresql-11
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
* binaire principal : /usr/lib/postgresql/11/bin/postgres

<br>
* binaires pg : /usr/bin/ (pg_*)


<br>
# Processus forkés


```
postgres -D /var/lib/postgresql/11/main -c config_file=/etc/postgresql/11/main/postgresql.conf
  \_ postgres: 11/main: checkpointer process   
  \_ postgres: 11/main: writer process   
  \_ postgres: 11/main: wal writer process   
  \_ postgres: 11/main: autovacuum launcher process   
  \_ postgres: 11/main: stats collector process   
  \_ postgres: 11/main: bgworker: logical replication launcher 
```

