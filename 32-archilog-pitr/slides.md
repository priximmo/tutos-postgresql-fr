%titles Postgresql
%author: xavki

# PITR : PG_BASEBACKUP et archive des WAL


<br>

* notion : Point In Time Recovery (PITR)

* sauvegarde physique pg_basebackup + WAL nécessaires

<br>

* fréquence du pg_basebackup / WAL = durée de restauration

* une fois par semaine pg_basebackup

Doc : https://public.dalibo.com/exports/formation/manuels/modules/i2/i2.handout.html#copie-physique-%C3%A0-chaud-ponctuelle-avec-pg_basebackup


* scheminement

createdb + table + insert >>>> pgbasebackup >>>>>> insert2  >>>>>>>> insert 3

---------------------------------------------------------------------

# WAL archivage : configuration

<br>

* activation de l'archivage des wal /etc/.../postgresql.conf

```
mkdir /tmp/wal/

wal_level = replica
archive_mode = on
archive_command = 'test ! -f /tmp/wal/%f && cp %p /tmp/wal/%f'

service postgresql restart
```

-------------------------------------------------------------------

# PG_BASEBACKUP

<br>

* création d'une base :

```
createdb jetestbackup
```

<br>

* insertion de datas :

```
psql jetestbackup -c "CREATE TABLE xavki (id int)";
psql jetestbackup -c "INSERT INTO xavki SELECT * FROM GENERATE_SERIES(1,20000);"
psql jetestbackup -c "\dt+"
date
```

-------------------------------------------------------------------

# PG_BASEBACKUP


<br>

```
psql -c "select pg_switch_wal();"
mkdir /tmp/bck/
pg_basebackup -Ft -X none -D - | gzip > /tmp/bck/files.tar.gz
ls /tmp/bck
```

<br>

* ajout de datas après backup

```
psql jetestbackup -c "CREATE TABLE xavki2 (id int)";
psql jetestbackup -c "INSERT INTO xavki2 SELECT * FROM GENERATE_SERIES(1,20000);"
psql jetestbackup -c "\dt+"
psql -c "select pg_switch_wal();"
date
```

```
psql jetestbackup -c "CREATE TABLE xavki3 (id int)";
psql jetestbackup -c "INSERT INTO xavki3 SELECT * FROM GENERATE_SERIES(1,20000);"
psql jetestbackup -c "\dt+"
psql -c "select pg_switch_wal();"
```

Rq : fichiers de la base et les wal séparés


--------------------------------------------------------------------


# PG_BASEBACKUP : restauration


<br>

* clean > restauration physique (fichiers)

```
service postgresql stop
rm -rf /var/lib/postgresql/10/main/*
tar xvfz /tmp/bck/files.tar.gz -C /var/lib/postgresql/10/main/
```

<br>

* création du fichier recovery

```
vim /var/lib/postgresql/10/main/recovery.conf
restore_command = 'cp /tmp/wal/%f %p'
recovery_target_time = '2020-01-31 12:20:00 UTC'
service postgresql start
```
