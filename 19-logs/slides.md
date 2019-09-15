%titles Postgresql
%author: xavki


# Logs


<br>
* à ne pas confondre avec les logfiles (transacations - WAL)

* répertoire : $PG_DATA/pg_log/

<br>
* attention : plus de log =  moins de perfs

* postgresql = découplage entre la collecte du log et son écriture
			* processus = logging collector

<br>
* paramétrage dans le /etc/postgresql/../../postgresql.conf

* paramètres log_destination : type de logs
			* stderr
			* csvlog
			* syslog
			* eventlog

-------------------------------------------------------------------------

# Logs - Paramètres


<br>
* log_directory = localisation

* log_filename = format des noms des fichiers (standard strftime)

<br>
* attention : log_truncate écrase les fichiers si ON

<br>
* information contenue dans les logs = log_statement
			* attention aux performances
			* none : erreurs uniquement
			* ddl : none + erreurs
			* mod : ddl + changements de datas (insert, update, delete)
			* all : mod + select
<br>
* log_line_prefix = format des lignes de logs

<br>
* logs concernant d'autres éléments :
			* log_checkpoints = on
			* log_connections = on
			* log_disconnections =on
			* log_duration = on

--------------------------------------------------------------------------

# Logs - Debug


<br>
* logguer peu pour la performance

<br>
* ponctuellement pour debugger augmenter les logs

* ajout en fonction du besoin

<br>
* pour une database :

```
ALTER DATABASE xavier SET log_statement = 'all';
```

<br>
* pour un user :

```
ALTER USER xavki IN DATABASE xavier SET log_statement = 'all';
```

<br>
* logger requêtes lentes

```
log_min_duration = -1
```

Rq : -1 = rien sinon en millisecondes / indépendant de log_statement

