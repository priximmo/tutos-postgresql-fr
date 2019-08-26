%title: Postgresql
%author: xavki


# Postgresql : binaires



<br> 
* pg_ctl :
	- gestion de l'instance/cluster
	- start/stop/kill
	- init: création autre espace de datas
	- promote : promotion du standby


<br>
* psql :
	- client de connexion à un cluster
	- précision utilisateur et/ou db
	- passage de sql en cli ou script sql



--------------------------------------------------------------------------

# Spécifique Debian


<br>
* pg_createcluster :
	- création d'un cluster (une instance PG)
	-	création des répertoires (/etc /var/lib/)


<br>
* pg_dropcluster :
	- suppression d'un cluster
	- cluster arrêté


<br>
* pg_lscluster :
	- lister les cluster


<br>
* pg_ctlcluster :
	- équivalent du pg_ctl
	- contrôle du cluster (stop/start...)


--------------------------------------------------------------------------


# Spécifiques Sauvegardes


<br>
* pg_dump:
	- sauvegarde d'une instance
	- différents formats : plain text, binaire...
	- différents niveaux d'objets (cluster/db/table/schéma)


<br>
* pg_dumpall:
	- sauvegarde intégrale en format binaire


<br>
* pg_restore:
	- restauration à partir d'une sauvegarde (pg_dumpall)



-------------------------------------------------------------------------

# Wrappers


* équivalent de commandes sql

<br>
* createdb :
	- création d'une base de données


<br>
* dropdb :
	- suppression d'une base de données


<br>
* createuser :
	- création d'un utilisateur


<br>
* dropuser :
	- suppression d'un user


-------------------------------------------------------------------------


# Maintenance

<br>
* reindexdb :
	- réindexation des index avec des paramètres pour restreindre le périmètre


<br>
* vacuumdb :
	- tâche de maintenance (ménage)


<br>
* vacuumlo :
	- suppression de large objects


--------------------------------------------------------------------------


# Spécifiques système avancées



<br>
* pg_controldata : 
	- vérifie l'état du serveur et des infos critiques


<br>
* pg_resetwal : 
	- en cas de crash avec pb de  WAL (Write Ahead Logging) 
	- attention : datas inconsistentes (dernier recours)


<br>
* pg_receive_wal :
	- récupération des WAL d'une autre DB


<br>
* pg_basebackup:
	- récupération de datas par une connexion à une autre DB (ex : init réplication)
