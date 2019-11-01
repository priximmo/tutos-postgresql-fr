%titles Postgresql
%author: xavki

# Patroni : solution intégrale


<br>
* solution mise au point part Zalendo

https://patroni.readthedocs.io/

* à base de python

* management de postgresql

* gestion automatique de failover grâce à une API

* stockage avec un ETCD (stockage clef/valeur)

<br>

```
                   +---------+
 +--------+    +---+   PG1   |
 |  ETCD  +----+   +---------+
 +--------+    |
               |   +---------+
 +--------+    +---+   PG2   |
 | HAPROXY+----+   +---------+
 +--------+    |
5000     8008  |   +---------+
               +---+   PGx   |
                   +---------+
```

--------------------------------------------------------------------

# ETCD

<br>
* idéal en cluster et isolé

* exemple : haproxy + etcd = même machine

<br>
```
apt-get install -y etcd haproxy	

vim /etc/default/etcd

ETCD_LISTEN_PEER_URLS="http://192.0.2.21:2380"
ETCD_LISTEN_CLIENT_URLS="http://localhost:2379,http://192.0.2.21:2379"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://192.0.2.21:2380"
ETCD_INITIAL_CLUSTER="etcd0=http://192.0.2.21:2380,"
ETCD_ADVERTISE_CLIENT_URLS="http://192.0.2.21:2379"
ETCD_INITIAL_CLUSTER_TOKEN="cluster1"
ETCD_INITIAL_CLUSTER_STATE="new"

systemctl restart etcd
```

-------------------------------------------------------------------

# POSTGRESQL - PATRONI


<br>
* module etcd pour python et postgresql

```
apt-get install -y python-etcd postgresql-11
```

* mise en place de patroni

```
systemctl stop postgresql
ln -s /usr/lib/postgresql/11/bin/pg_ctl /usr/bin/
apt-get install patroni
mkdir /data/patroni -p
chown postgres:postgres /data/patroni
chmod 700 /data/patroni
vim /etc/patroni.yml
```

------------------------------------------------------------------

# POSTGRESQL - PATRONI


```
vim /etc/systemd/system/patroni.service

[Unit]
Description=Runners to orchestrate a high-availability PostgreSQL
After=syslog.target network.target
[Service]
Type=simple
User=postgres
Group=postgres
ExecStart=/usr/bin/patroni /etc/patroni.yml
KillMode=process
TimeoutSec=30
Restart=no
[Install]
WantedBy=multi-user.target
```

```
systemctl daemon reload && systemctl restart patroni
```

-----------------------------------------------------------------

# HAPROXY

```
vim /etc/haproxy/haproxy.cfg

global
	maxconn 100
defaults
	log global
	mode tcp
	retries 2
	timeout client 30m
	timeout connect 4s
	timeout server 30m
	timeout check 5s
listen stats
	mode http
	bind *:7000
	stats enable
	stats uri /
listen postgres
	bind *:5000
	option httpchk
	http-check expect status 200
	default-server inter 3s fall 3 rise 2 on-marked-down shutdown-sessions
	server postgresql_192.168.60.3_5432 192.168.60.3:5432 maxconn 100 check port 8008
	server postgresql_192.168.60.4_5432 192.168.60.4:5432 maxconn 100 check port 8008

service haproxy restart
```

----------------------------------------------------------------

# TEST


```
psql -h 192.168.60.5 -p 5000 -U postgres
CREATE DATABASE xavier;
systemctl stop patroni
patronictl -c /etc/patroni.yml list
etcdctl ls / --recursive
etcdctl get /db/postgres/members/postgresql1
```
