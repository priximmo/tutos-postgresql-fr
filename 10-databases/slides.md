%title: Postgresql
%author: xavki


# Databases


<br>
Rappel :
Serveur > Cluster > Databases > Tables


<br>
* database = un contenant partageant ses ressources (au sein du cluster)

* l'objet élémentaire est la table

* les tables sont composées de colonnes et de lignes

* les colonnes sont de différents types : int, varchar, date...


------------------------------------------------------------------------------------



# Autre options



```
CREATE DATABASE name
    [ [ WITH ] [ OWNER [=] user_name ]
           [ TEMPLATE [=] template ]
           [ ENCODING [=] encoding ]     >> encodage (utf8...)
           [ LC_COLLATE [=] lc_collate ] >> tri des strings
           [ LC_CTYPE [=] lc_ctype ]     >> type de caractères (maj, min...)
           [ TABLESPACE [=] tablespace ]
           [ CONNECTION LIMIT [=] connlimit ] ]
```

-------------------------------------------------------------------------------------



# Création

<br>
* créer une database :

```
CREATE DATABASE mydb WITH ENCODING 'UTF-8' TEMPLATE TEMPLATE 0;
```

template1 > template0 > création DB

<br>
* avec le wrapper

```
createdb -T template0 mydb
```

Remarque : on peut utiliser n'importe quelle base à l'arrêt comme template (modèle)


