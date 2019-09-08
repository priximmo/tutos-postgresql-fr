%titles Postgresql
%author: xavki


# Droits - Schéma

<br>
* schémas = vues des objects de la bases de données

* objectif : faciliter la gestion des droits

* schéma par défaut = public


<br>
* création d'un schéma au sein d'une database

```
\c xavki xavier
\dn
CREATE SCHEMA monschema;
```

<br>
* autoriser un user à créer un schéma

```
GRANT CREATE ON DATABASE xavki TO toto;
\c xavki toto
```

<br>
* supprimer les droits

```
REVOKE CREATE ON DATABASE xavki FROM toto;
```

-----------------------------------------------------------------

# Tables et Schémas

<br>
* comment créer une table dans un schéma ?

<br>
* deux méthodes :
		* search_path
		* préfix <nom_schéma>.<nom_table>

<br>
* search_path :

```
SET SEARCH_PATH = monschema;
CREATE TABLE tb1 (id int);
```
* avec préfix :

```
CREATE TABLE monschema.tb2 (id int);
```

-----------------------------------------------------------------

# Où suis-je ?

<br>
* quel schéma ?

```
SHOW SEARCH_PATH;
```

<br>
* schéma par défaut = public

* aller à dans un autre schéma

```
SET SEARCH_PATH = monschema;
```

<br>
* changement de schéma par défaut

```
ALTER USER xavier SET SEARCH_PATH = monschema;
```

------------------------------------------------------------------

# Droits - Schéma

<br>
* 2 permissions :
		* USAGE : lecture dans un schéma
		* CREATE : création de tables dans un schéma

<br>
* grant

```
GRANT CREATE ON SCHEMA monschema TO xavier;
```

Rq : possible de faire vers tous les users PUBLIC





