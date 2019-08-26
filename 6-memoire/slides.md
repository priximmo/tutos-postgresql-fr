%title: Postgresql
%author: xavki



# Postgresql : la mémoire


<br>
* très important pour un moteur de BDD

* accessibilité rapide à la donnée

<br>
* la mémoire n'est pas pérenne :
		- cas d'arrêt : prévu > système d'écriture
		- indicent : imprévu > perte de la mémoire / recovery

<br>
* posgtres scinde en 4 la mémoire disponible :
		- shared buffer : mémoire partagée
		- wal buffers
		- work mem
		- maintenance work mem

* on appelle shared memory = shared buffer + wal buffer + c-log-buffer


-------------------------------------------------------------------

# Shared Buffer


* par défaut 128 Mo


* au mini 128ko + 16 ko par max connexions


* si plus 25% de celle du système


* cette partie de la mémoire est ensuite écrite sur datafile


* data plus rapide que sur datafile


* background writer : process chargé de la copie



-------------------------------------------------------------------

# WAL Buffer


* en charge des archives des transactions


* cette partie est ensuite écrite dans les WAL files puis archivé


* wal writer : en charge de la copie


* archiver : process en charge de l'archivage




------------------------------------------------------------------

# Work mem


* mémoire allouée pour chaque utilisateur


* permet les tri, classement, filtre, jointures... des requêtes clientes


* affectation pour chaque connexion 


* cf postgresql.conf > reload nécessaire


------------------------------------------------------------------


# Maintenance work mem


* mémoire dédiée aux opérations de maintenance


* vaccum, create index, reindex...


* valeur qui peut jouer sur la vitesse de restauration




