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


-------------------------------------------------------------------

# Shared Buffer


* cette partie de la mémoire est ensuite écrite sur datafile


* data plus rapide que sur datafile


* background writer : process chargé de la copie



-------------------------------------------------------------------

# WAL Buffer



* cette partie est ensuite écrite dans les WAL files puis archivé


* wal writer : en charge de la copie


* archiver : process en charge de l'archivage




------------------------------------------------------------------

# Work mem


* mémoire allouée pour chaque utilisateur


* affectation pour chaque connexion 


* cf postgresql.conf > reload nécessaire


------------------------------------------------------------------


# Maintenance work mem






