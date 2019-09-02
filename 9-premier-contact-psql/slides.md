%title: Postgresql
%author: xavki


# PSQL : les débuts


<br>
* connexion par défaut en connexion local

```
psql
```

Remarque : 
	- cluster : main
	- port : 5432
	- serveur : localhost
	- user : postgres

<br>
* avec des options et en passant par la socket (pas local)

```
psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
```

Rq : --cluster dans le cas de plusieurs cluster ou nom différent

----------------------------------------------------------------------

# Quelques options utiles

<br>
* -c : passer des commandes à partir de la CLI

<br>
* -L : logger la CLI

<br>
* -f : passer des fichiers de scripts sql

<br>
* -H : export en html

<br>
* -s : marque un temps d'arrêt à chaque requête (passage de fichier -f)

<br>
* -q : mode silencieux sans message

<br>
* -t : uniquement les lignes de résultats

----------------------------------------------------------------------

# Quelques commandes


<br>
* lister les databases

```
\l+
```

Rq: + > volumétrie

<br>
* lister les users

```
\du
```

<br>
* lister les tables

```
\dt+
```

<br>
* lister les schémas

```
\dn
```

<br>
* lister les champs d'une table

```
\dS <nom_table>
```



