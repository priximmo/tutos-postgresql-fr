%title: Postgresql
%author: xavki



# Postgresql : les différents processus


<br>
* processus père : postgresql -D <data_dir> -c <conf_dir>


* principe de fork


<br>
* 2 type de fils :
	- les processus du moteur
	- les processus affectés aux connexions	



---------------------------------------------------------


# Processus 



<br>
* le checkpointer : permet poser des jalons mémoire/disque
		- écriture des dirty pages (mémoire) sur les data files (disque)
		- paramétrage de cette fréquence d'écriture
		- soit en durée et/ou en nombre de WAL switch
		- configuration dans postgresql.conf
		- param : checkpoint_segments et checkpoint_timeout
		- important pour le recovery notamment (coût en perf)

<br>
* writter : écriture des dirty pages (mémoire) sur data files (dique)

<br>
* wall writer : écriture de wal buffer sur disque

<br>
* autovaccum launcher : en charge de l'autovaccum

<br>
* stats collector : calcule les statistiques
		- hyper important pour le fonctionnement d'un moteur 
			(traitement efficace des requêtes)
		- écriture dans pg_stats_temp	

<br>
* logical replication launcher : 
		- en cas de réplication logique
		- lance un process pour les standby qui se connectent

* postgres postgres (idle) : pour chaque connexion
		- allocation de la ressource
		- work memory
	
