%title: Postgresql
%author: xavki


# INDEX : Hash


<br>
* objectif : augmente la vitesse des requêtes

* index = table structurée pour un besoin

* index = pointeur

* attention : 
		* index = entretien (réindex)
		* index = baisse performance en écriture

* postgresql dispose de plusieurs types d'index :
		* b-tree (r-tree spatial)
		* hash
		* Gist
		* Gin
		* Brin

* création d'un index :

```
CREATE INDEX idx_xavki ON xavier USING HASH (t_champs1);
```

* cas d'utilisation : = ou <>
		* table longue
		* champs de jointures
		* nb de valeurs dans le champs importants
		* peu de valeurs rapatriées
		* éviter sur les tables mises à jour régulièrement

* complément : https://fr.wikipedia.org/wiki/Arbre_B

------------------------------------------------------------

# Hash


<br>
* une fonction de hashage => hash la clef

* le résultat est un entier qui détermine le positionnement du pointeur

* le pointeur pointe vers la ligne correspondante

<br>
* exemple : 

1. la table

```
 +---------------+
 | Nom  | Données|
 +---------------+
 | Paul | rouge  |
 | Jean | vert   |
 | René | bleu   |
 +---------------+
```

2. le hachage

```
	hash(Paul) = 2
  hash(Jean) = 3
  hash(René) = 1 
```
------------------------------------------------------------

# Hash

3. l'index

```
  +---------------------+
  | Index|  Pointeur    |
  +---------------------+
  | René |      a       |
  | Paul |      b       |
  | Jean |      c       |
  +---------------------+
```

<br>
4. la recherche


	1. je cherche Paul
	2. hash(Paul) = 2
	3. recherche du pointeur dans l'index 2
	4. correspondance du pointeur dans la table
	5. rouge

--------------------------------------------------------------

# Vérification

```
CREATE TABLE xavier (id int);
INSERT INTO xavier SELECT * FROM GENERATE_SERIES(1,2000000);
\timing
SELECT * FROM xavier WHERE id = 1555555;
EXPLAIN ANALYZE select * from xavier where id =1555555;
CREATE INDEX idx_xavier_id ON xavier USING HASH (id);
SELECT * FROM xavier WHERE id = 1555555;
EXPLAIN ANALYZE select * from xavier where id =1555555;
```
