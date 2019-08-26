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



