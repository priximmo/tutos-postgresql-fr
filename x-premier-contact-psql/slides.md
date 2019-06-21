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
	- port : 54532
	- serveur : localhost
	- user : postgres

<br>
* avec des options et en passant par la socket (pas local)

```
psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
```



