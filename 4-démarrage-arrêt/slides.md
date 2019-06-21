%title: Postgresql
%author: xavki


# Postgresql : démarrage et arrêt

<br>
* très important pour un moteur de BDD
	- consistence des données
	- capacité à récupérer les données manquantes


# Démarrage

<br>
1. Ressources ? : Affectation de la mémoire partagée
		- shared_buffers (défaut 128 Mb)
		- paramétré dans /etc/.../postgresql.conf
		- paramétré par clusterPG

<br>
2. Où on en est ? : Lecture des fichiers de contrôle (control files)
		- pg_control dans $PGDATA/global
		- état de la base en fonction de l'arrêt

<br>
3. Si récupération nécessaire ? : checkpoint
		- où sont disponibles les transactions manquantes ?
		- sur data file (disque) ou non ?

<br>
4. Si transactions disponibles sur WAL :
		- relancement des transactions

<br>
5. Si pas de récupération possible ? erreur

<br>
6. Sinon tout est ok ? PG écoute et autorise les connexions


-----------------------------------------------------------------------------


# Arrêt


1. OS : Signal d'arrêt

Si Type SIGINT (intermédiaire)

2. Nouvelles connexions coupées

3. Stop les autres connexions

4. Rollback des transactions en cours

Si type SIGTERM (soft)

2. Coupe les nouvelles connexions

3. Fini les transactions en cours


---------------------------------------------------------------------------


# Arrêt


Dans tous les cas :

5. écriture d'un checkpoint

6. écriture de la mémoire sur disque (data files)

7. mise à jour des control files (pg_control)

Rq : 
- peu prendre suivant les datas en mémoire
- attente si un checkpoint est déjà en cours


Si SIGQUIT (arrêt brutal) :

- pas de checkpoint

- pas d'écriture des datas sur disque

- pas de maj des control files

- recovery

- pertes de transactions (datas)


