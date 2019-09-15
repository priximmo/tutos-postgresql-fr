%titles Postgresql
%author: xavki


# Restauration


<br>
* deux méthodes suivant le mode de backup :
		* en plain texte : psql -f pour jouer le SQL
		* en binaire : pg_restore

* création d'une DB de test :

```
createdb madatabase
psql -d madatabase -c "CREATE TABLE tb1 (id int)"
psql -d madatabase -c "CREATE TABLE tb2 (id int)"
psql -d madatabase -c "INSERT INTO tb1 SELECT * FROM GENERATE_SERIES(1,1000)" 
psql -d madatabase -c "INSERT INTO tb2 SELECT * FROM GENERATE_SERIES(1,1000)" 
```

-----------------------------------------------------------------------

# PSQL - Toutes les databases


<br>
* sauvegarde

```
pg_dump > dump.sql    		# sans les users
pg_dumpall > dumpall.sql	# avec les users
```


<br>
* restauration

```
psql -f dump.sql
```

Rq : on évitera pour les grosses bases de copier les datas
utilisation de l'option -Fc --data-only binaire plus léger
et un autre --schema-only pour la structure

-----------------------------------------------------------------------

# PSQL - Une database


<br>
* sauvegarde d'une database :

```
pg_dump -d madatabase > madatabase.sql
```

<br>
* restauration

```
dropdb madatabase
createdb madatabase && psql -f madatabase.sql
```

* ou plus simplement si le dump prévoit le CREATE DATABASE -C

```
pg_dump -C -d madatabase > madatabase.sql
psql -F madatabase.sql
```

-------------------------------------------------------------------

# PSQL - Une table

* sauvegarde

```
pg_dump -d madatabase -t tb1 > tb1.sql
```

* restauration

```
psql -d madatabase -f tb1.sql
```

-------------------------------------------------------------------

# PG_RESTORE


* s'utilise sur les fichiers binaires pg_dump -Fc

```
pg_dump -Fc -d madatabase > madatabase.dump
```

* restauration

```
dropdb madb
createdb madatabase
pg_restore -d madatabase -c madatabase.dump
```

