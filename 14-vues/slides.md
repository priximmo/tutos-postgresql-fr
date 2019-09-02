atitles Postgresql
%author: xavki


# INDEX : Vues

* intérêts :
		* éviter de refaire régulièrement des requêtes (complexes)
		* faciliter la gestion des droits pour masquer des colonnes

* création de la table

```
CREATE TABLE xavier (id INT, champs1 VARCHAR);
INSERT INTO xavier (id,champs1) VALUES (1,'pierre');
INSERT INTO xavier (id,champs1) VALUES (2,'paul');
INSERT INTO xavier (id,champs1) VALUES (3,'jacques');
```

--------------------------------------------------------

# Vue classique - exemple



* création de la vue

```
CREATE VIEW v_compte AS SELECT COUNT(*) FROM xavier;
CREATE VIEW v_all AS SELECT * FROM xavier;
\dS xavier
\dS v_xavier
SELECT * FROM v_compte;
DELETE FROM xavier WHERE id = 1;
SELECT * FROM v_compte;
```

* attention si évolution de la table = recréer la vue

```
ALTER TABLE xavier ADD COLUMN champs2 VARCHAR NOT NULL DEFAULT NOW()::date;
SELECT * FROM v_all;
```

-------------------------------------------------------

# Vue matérialisée - exemple



* création de la vue matérialisée

```
CREATE MATERIALIZED VIEW vm_xavier AS SELECT * FROM xavier;
SELECT * FROM vm_xavier;
DELETE FROM vm_xavier WHERE id = 2;
SELECT * FROM xavier;
SELECT * FROM vm_xavier;
```


