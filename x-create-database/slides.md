%title: Postgresql
%author: xavki



# Postgresql : création d'une base



<br>
* deux manières :
		- createdb : binaire à partir d'une commande shell
		- psql : commande sql


<br>
## Binaire createdb

* createdb les principales options :

<br>
* -D ou --tablespace : 
		- location du répertoire des fichiers de données

<br>
* -E ou --encoding :
		- type d'encodage

-l ou --locale


<br>
* -O ou --owner :
		-	propriétaire de la base
		- doit être créé préaliablement


<br>
* -T ou --template :
		- modèle utilisé
		- template0 / template1 / postgres


---------------------------------------------------------------------------



## Accès distant ou spécifique



<br>
* d'une autre machinea
* idem psql


<br>
* -h ou --host : 
		- adresse ou ip du serveur


<br>
* -p ou --port :
		- port de connexion (defaut 5432)


<br>
* -U ou --username :
		- user utilisé pour créer la DB (owner)

<br>
* -W :
		- affichage du prompt pour le password

