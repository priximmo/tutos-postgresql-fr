%titles Postgresql
%author: xavki


# COPY - réaliser des exports


<br>
* \h COPY 


<br>
* création d'une table

```
CREATE TABLE tbl1 (id int);
INSERT INTO tbl1 SELECT * FROM generate_series(1,2000000);
```

* export vers un fichier texte

```
COPY tb1 TO '/tmp/export_tb1.txt';
```

* export en csv

```
COPY tb1 TO '/tmp/export_tb1.txt' CSV HEADER;
```

--------------------------------------------------------------

# COPY - personnalisation


<br>
* exporter une requête précise

```
COPY (SELECT COUNT(*) FROM tb1) TO '/tmp/count.txt';
```

<br>
* export vers une command shell

```
COPY tbl1 TO PROGRAM 'wc -l > /tmp/shell_count.txt';
```

<br>
* import de données - ex : curl

```
COPY tbl1 FROM PROGRAM 'curl http://exemple.com';
```
