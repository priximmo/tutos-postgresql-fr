atitles Postgresql
%author: xavki


# USERS et ROLES

<br>
* gestion des droits : databases, schéma, tables, colonnes...

<br>
* en postgresql : users = roles

<br>
* un user/role existe pour un cluster PG (instance)

<br>
* lien avec le pg_hba pour les autorisations de connexions à la socket

<br>
* possibilité d'héritage = principe de roles (similaire à Oracle)

<br>
 * user = login + mdp + droits

<br>

lister les users/roles :

```
\du
```
<br>
* utilisation de trust pour connexion locale


---------------------------------------------------------------------------

# USERS/ROLES : création

<br>
```
postgres=# \h create user
Command:     CREATE USER
Description: define a new database role
Syntax:
CREATE USER name [ [ WITH ] option [ ... ] ]
where option can be:
      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | REPLICATION | NOREPLICATION
    | BYPASSRLS | NOBYPASSRLS
    | CONNECTION LIMIT connlimit
    | [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
    | VALID UNTIL 'timestamp'
    | IN ROLE role_name [, ...]
    | IN GROUP role_name [, ...]
    | ROLE role_name [, ...]
    | ADMIN role_name [, ...]
    | USER role_name [, ...]
    | SYSID uid
```

------------------------------------------------------------------------


# USERS : Options

* SUPERPUSER : fait ce qu'il veut

* CREATEDB : autorise la création de database

* CREATEROLE : autorise la création d'autres rôles/users

* INHERIT ROLE : héritage d'un autre rôle en mentionnant son nom

* LOGIN : autorise la connexion à l'instance

* REPLICATION : spécifique

* CONNECTION LIMIT : nombre maximum de connexions concurrentes

* PASSWORD / ENCRYPTED PASSWORD : définition du mot de passe entre simples quotes

* VALID UNTIL : définir une date de péremption/validité

* ADMIN : niveau admin (DBA oracle)
------------------------------------------------------------------------


# Exemple


```
CREATE USER toto NOLOGIN
```
