%title: Postgresql
%author: xavki



# Postgresql : principaux répertoires


<br>
* 2 essentiels

```
/var/lib/postgresql/11/main/
/etc/postgresql/11/main/
```

<br>
* datas : /var/lib...

* conf : /etc/...

-------------------------------------------------------

# Répertoires


<br>
* base
		- localisation des bases
		- template 0 et template 1 : appelé lors de la création de DB
		- postgresql
		- classement par oid (tables de correspondance entre oid et objets)
		- SELECT relname, oid, relfilenode FROM pg_class;
		- ex : SELECT relname, oid, relfilenode FROM pg_class where relname='xavier';
		- ou SELECT pg_relation_filepath('xavier');
		- Free Space Map (FSM) et Visibility Map (VM) : espace dispo , lien avec Vacuum

<br>
* global :
		- control files : pg_control appelés au démarrage
		- connaître l'état du moteur

<br>
* pg_wal : 
		- write ahead log (WAL)
		- wal files : défaut 16 Mb
		- perf = déplacement sur disques performants (ssd)
		- recovery (checkpoint) : rejoue les fichiers wal


------------------------------------------------------------------


# Répertoires



<br>
* pg_act :
		- statut des transactions non sérializable commitées (type d'isolation des transactions)

<br>
* pg_serial :
		- idem mais sérializable

<br>
* pg_stat:
		- statistiques : important pour élaboration des plans des requêtes

<br>
* pg_tblspc :
		- pointeur vers les tablespaces

<br>
* pg_repslot:
		- informations sur la réplication par slot

