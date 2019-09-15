%titles Postgresql
%author: xavki


# Backups : pg_dumpall


<br>
* important mais cela reste une image

* complémentaire à l'archive log

* pas de méthode unique => à adapter à sa situation

* COPIE les users et autres spécifiques à l'instance

<br>
* deux outils (complémentaires) :
			* pg_dump : personnalisation au maximum
			* pg_dumpall : backup intégral de l'instance (y compris users...)

* les dumps doivent être testés régulièrement :
		* à l'aise avec la restauration
		* être sûr que les backups fonctionnent

* les backups = stockés le plus loin possible des machines

--------------------------------------------------------

# Backups : pg_dumpall


<br>
* format = plain text = SQL 

<br>
* fichier volumineux (pas vraiment adapté pour les grosses bases)

* possibilité de retoucher

* SURTOUT copie des users/roles

<br>
Options : 

* -l : database

* -h : hostname

* -U : user utilisé

* -p : le port

* -f : le nom du fichier

* --schema-only : uniquement la structure

* --data-only : juste les datas

* --if-exist : supprime avant les objets existant


