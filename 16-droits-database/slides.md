%titles Postgresql
%author: xavki


# Droits - Database

<br>
* important pour du mutualisé : sécurité et isolation

<br>
* instance peu de limites en nb de DB 
https://www.endpoint.com/blog/2008/11/10/10000-databases-on-postgresql-cluster

Rq :limite du filesystem

<br>
* gestion des droits via la clause GRANT


-----------------------------------------------------------------


# SQL


<br>
* création d'une database

```
CREATE DATABASE madb OWNER TO xavier;
```

<br>
* changement de propriétaire 

```
ALTER DATABASE madb OWNER TO toto;
```

<br>
* affectation des droits

```
GRANT { { CREATE | CONNECT | TEMPORARY | TEMP } [, ...] | ALL [ PRIVILEGES ] }
    ON DATABASE database_name [, ...]
    TO role_specification [, ...] [ WITH GRANT OPTION ]
```


-----------------------------------------------------------------

# Sécurité database - exemple


<br>
* création de users xavier et toto

```
CREATE USER xavier LOGIN CREATEDB;
CREATE USER toto LOGIN CREATEDB;
```

<br>
* création d'une database en tant que user postgres

```
CREATE DATABASE xavki;
```

<br>
* changement de propriétaire

```
ALTER DATABASE xavki OWNER TO xavier;
```

Rq : on pouvait le faire directement

-----------------------------------------------------------------

# Sécurité database - exemple


<br>
* révocation des droits pour tous les users sauf le owner

```
REVOKE ALL ON DATABASE xavki FROM PUBLIC;
```

<br>
* test de connexion avec le user toto

```
\c xavki toto
```

<br>
* ajout des droits de connexion

```
GRANT CONNECT ON DATABASE xavki TO toto;
\c xavki toto
```

-----------------------------------------------------------------

# Sécurité database - exemple


<br>
* ne peut pas créer de schéma

```
CREATE SCHEMA myschema;
```

<br>
* autorisation de création des schémas :

```
GRANT CREATE ON DATABASE xavki TO toto;
\c xavki toto
```

Attention : si un schéma existe il faut aussi gérer les droits sur le schéma (REVOKE...)
