%titles Postgresql
%author: xavki


# Droits - tables et colonnes


<br>
* limitation pour les tables :
			* SELECT : sélection
			* INSERT : insertion de lignes
			* UPDATE : mise àjour de lignes
			* DELETE : suppression de lignes
			* TRUNCATE : vidéer la table
			* REFERENCES : utilisation de la table comme clef
			* TRIGGER : mise en place de déclencheurs
			* ALL

<br>
* syntax

```
GRANT ALL ON TABLE tbl1 TO <role_ou_public>;
REVOKE ALL ON TABLE tbl1 FROM <role_ou_public>;
```

----------------------------------------------------------------

# Droits - tables et colonnes


* exemple

```
\c xavier xavki
CREATE TABLE tbl1 (id int,champs1 varchar);
INSERT INTO tbl1 VALUES (1, 'hello');
INSERT INTO tbl1 VALUES (2, 'world');
REVOKE ALL ON TABLE tbl1 FROM toto;
\c xavier toto
INSERT INTO tbl1 VALUES (3, 'les xavkistes !!!');
\c xavier xavki
GRANT INSERT ON TABLE tbl1 TO xavki;
\c xavier toto
INSERT INTO tbl1 (3, 'les xavkistes !!!');
```

----------------------------------------------------------------


# Droits - tables et colonnes


<br>
* même principe pour les colonnes/champs de tables

* limitations possibles :
			* SELECT
			* INSERT
			* UPDATE
			* REFERENCES

<br>
* exemple

```
\c xavier toto
SELECT * FROM tbl1;
\c xavier xavki
REVOKE ALL ON TABLE tbl1 FROM toto;
GRANT SELECT(champs1) ON TABLE tbl1 to toto;
\c xavier toto
SELECT * FROM tbl1;
```

