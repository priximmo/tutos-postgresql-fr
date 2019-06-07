title: Postgresql
author: xavki


# Introduction

<br>
* Création Michael Stonebraker


<br>
* histoire :
		- 1974 Ingres : INtelligent Graphic RElational System
		- 1985 Post-Ingres = raccourci à Postgres
		- 1995 Postgres95
		- 1996 PostgreSQL

<br>
* moteur de BDD transactionnel

<br>
* dispose d'un langage PL/PgSql

<br>
* de nombreux outils autour :
		- client cli : psql
		- client GUI : pgAdmin
		-	postgis : volet géographique
		- nombreux système de réplications

* système d'extensions

<br>
* MVCC

* client/serveur : gestion de connexions

------------------------------------------------------------


# ACID : atomic, consistent, isolated, durable



<br>
Atomic : une transaction se fait en entier ou pas du tout


<br>
Consistent : en cas d'erreur lors d'une transaction l'état redevient celui d'avant celle-ci


<br>
Isolated : une transaction en cours d'interfère pas avec les autres


<br>
Durable : les données sont dispos en cas de redémarrage



-------------------------------------------------------------


# Définitions


<br>
* Cluster Machine > Cluster PG > Database > Rôles / Schémas > Tables > Champs


<br>
* Cluster Machine : plusieurs machines communiquants entre elles avec de la réplication


<br>
* Cluster PG : instances avec allocation de ressources spécific et définition de configuration


<br>
* Database : ensemble de données structurées (une application par exemple)

* Rôles/Users : utilisateurs avec login et mot de passe

* Schéma : Namespace ou espace de nom dans une base de données (un group d'éléments)

* Tables : espace de stockage logique dans une base de données

* Champs : une colonne de tables

* Lignes : une table est structurée en colonne/ligne


