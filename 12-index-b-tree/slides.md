%title: Postgresql
%author: xavki


# INDEX : B-tree


<br>
* objectif : augmente la vitesse des requêtes

* index = table structurée pour un besoin

* index = pointeur

<br>
* attention : 
		* index = entretien (réindex)
		* index = baisse performance en écriture

<br>
* postgresql dispose de plusieurs types d'index :
		* b-tree (r-tree spatial)
		* hash
		* Gist
		* Gin
		* Brin

<br>
* création d'un index :

```
CREATE INDEX idx_xavki ON xavier USING HASH (t_champs1);
```

<br>
* B-Tree : cas d'utilisation : < <= = >= > 
		* table longue
		* champs de jointures
		* peu de valeurs rapatriées
		* éviter sur les tables mises à jour régulièrement

* complément : https://fr.wikipedia.org/wiki/Arbre_B

------------------------------------------------------------

# B-Tree

* balancing tree : arbre équilibré

* créé par Rudolf Bayer qui travaillait chez Boeing

<br>
* arbre inversé : tronc + branches + feuilles

* Principe : ex: 1 2 3 4 5 6 7 8 9 10

```
                        +---------------+
                        | +---+   +---+ |
                        | | 4 |   | 9 | |  clefs
                        | +---+   +---+ |
         +---------------------------------------------+
         |                      |                      |
         |                      |                      |
 +---------------+   +-----------------------+     +-------+
 | +---+   +---+ |   | +---+   +---+   +---+ |     | +---+ |
 | | 1 |   | 3 | |   | | 5 |   | 6 |   | 8 | |     | | 10| |
 | +---+   +---+ |   | +---+   +---+   +---+ |     | +---+ |
 +---------------+   +-----------------------+     +-------+
           |                           |
     +-------+                   +-------+
     | +---+ |                   | +---+ |
     | | 2 | |                   | | 7 | |
     | +---+ |                   | +---+ |
     +-------+                   +-------+

```

--------------------------------------------------------------

# Vérification

```
CREATE TABLE xavier (id int);
INSERT INTO xavier SELECT * FROM GENERATE_SERIES(1,2000000);
\timing
SELECT * FROM xavier WHERE id = 1555555;
EXPLAIN ANALYZE select * from xavier where id =1555555;
CREATE INDEX idx_xavier_id ON xavier (id);
SELECT * FROM xavier WHERE id = 1555555;
EXPLAIN ANALYZE select * from xavier where id =1555555;
```
