%title: Postgresql
%author: xavki


# Databases et Tables


<br>
Rappel :
Serveur > Cluster > Databases > Tables


<br>
* database = un contenant partageant ses ressources (au sein du cluster)

* l'objet élémentaire est la table

* les tables sont composées de colonnes et de lignes

* les colonnes sont de différents types : int, varchar, date...

<br>
* différents types de tables :
		* classiques
		* temporaires : seulement en mémoire
		* avec héritage : récupère les colonnes de la table mère
		* partitionnement : découpage en plusieurs "sous-table" par élément d'une colonne
		* non loguée : sans écriture des logs (traces des transactions) > plus rapide mais perte datas si crash


--------------------------------------------------------------------------------

# Classiques


<br>
Création d'une table : 

```
CREATE TABLE matable (id int, varchar(255))
```

<br>
Principaux types de champs (colonnes) :
		* int
		* varchar
		* char
		* date
		* float
		* double
		* timestamp
		
<br>
Autres actions :

* suppression:

```
DROP TABLE toto;
```

<br>

* vider

```
TRUNCATE TABLE toto;
```

<br>

* modifier

```
ALTER TABLE (ALTER COLUMN ou ADD COLUMN) ...
```

------------------------------------------------------------------------------

# UNLOGGED - exemple


<br>
```
CREATE TABLE toto (champs1 int);

\timing
INSERT INTO toto SELECT * FROM GENERATE_SERIES(1,2000000);

ALTER TABLE toto SET UNLOGGED ;
INSERT INTO toto SELECT * FROM GENERATE_SERIES(1,2000000);
```

------------------------------------------------------------------------------


# Temporaires (en mémoire)

```
CREATE TEMPORARY TABLE toto (champ1 int);
```

<br>
# Héritage

```
CREATE TABLE titi (champs2 char(2) INHERITS (toto);

```

<br>
# Partitionnement

exemple :

```
CREATE TABLE temperature (measure_timestamp TIMESTAMPTZ,
                          sensor_id INTEGER,
                          measure_value DOUBLE PRECISION,
                          measure_unite custom_enum_unit)
                          PARTITION BY RANGE (measure_timestamp);

CREATE TABLE temperature_201709
PARTITION OF temperature
FOR VALUES FROM ('2017-09-01') TO ('2017-10-01');

CREATE TABLE temperature_201710
PARTITION OF temperature
FOR VALUES FROM ('2017-10-01') TO ('2017-11-01');

INSERT INTO temperature SELECT
	tval, sensorid, (100.0*random())-50.0, '°C'
	FROM  generate_series('2017-10-01 00:00:00',CURRENT_TIMESTAMP,'1 minute'::interval) tval
	CROSS JOIN generate_series(1,1000,1) sensorid
```

Lien : https://www.loxodata.com/post/cantwaitpg11_part/
