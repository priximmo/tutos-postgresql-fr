%titles Postgresql
%author: xavki


# REPMGR - failover keepalived

<br>
* faire porter une VIP par le master

* ajout d'une route pour la vip

```
sudo ip route add 192.168.99.1/32 via 192.168.99.110
```

* utilisation de "repmgr cluster show"

<br>
* adaptation des paramètres kernel pour keepalived (/etc/sysctl.conf): 

```
net.ipv4.ip_nonlocal_bind = 1
net.ipv4.conf.all.arp_announce = 2
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
```

```
systctl -p /etc/sysctl.conf
```


<br>
* installation de keepalived :

```
apt-get install keepalived
```

------------------------------------------------------------------

# REPMGR/Keepalived : script de M/S

<br>
* deux cas de figure à gérer
		* lorsque le primaire est vraiment connu comme primaire
		* en cas de fail (arrêt du master puis relance après bascule M/S)

<br
* primaire effectif :

```
primary_primary=`sudo -u postgres repmgr cluster show 2>/dev/null | awk -F '|' -v host="$HOSTNAME" '$2 ~ host && $3 ~ "primary" && $4 ~ "* running" {print $2}' | tr -d "\"" | tr -d " "`
```

<br>
* le slave qui est master (plus rare) : suite à arrêt du master et redémarrage

* si cette situation gestion particulière = vip sur le slave

```
standby_primary=`sudo -u postgres repmgr cluster show 2>/dev/null | awk -F '|' '$3 ~ "standby" && $4 ~ ".* as primary" {print $2}' | tr -d "\"" | wc -l`
```

-----------------------------------------------------------------------

# REPMGR/Keepalived : script de M/S

<br>
* keepalived se base sur le code retour ( 0 = ok; autre = fail)

<br>
* si on a

```
as primary = uniquement sur un slave qui a redémarré
```

```
étoile running = ip/nom correspondant au master normalement (sauf retour de master = split brain)
```

<br>
* donc : 
		* si aucun split brain => as primary = 0 => étoile running => master
		* si split brain => as primary > 0 sur l'ancien master revenu => slave

-----------------------------------------------------------------------

# REPMGR/Keepalived : conf master

vrrp_script postgres {
                script "/home/vagrant/test.sh"
                interval 1
}
vrrp_instance VI_1 {
   virtual_router_id 100
   state MASTER
   priority 100
   # fréquence du check
   advert_int 1
   # définition de l'interface de synchro entre les LB 
   lvs_sync_daemon_interface eth1
   interface eth1
   # authentification entre les 2 machines
   authentication {
                auth_type PASS
                auth_pass secret
   }
   # définition de la vip
   virtual_ipaddress {
       192.168.60.5/32 brd 192.168.60.255 scope global
   }
   track_script {
      postgres
   }
}

---------------------------------------------------------------------------

# REPMGR/Keepalived : conf slave

vrrp_script postgres {
                script "/home/vagrant/test.sh"
                interval 1
}
vrrp_instance VI_1 {
   virtual_router_id 100
   state BACKUP 
   priority 50
   # fréquence du check
   advert_int 1
   # définition de l'interface de synchro
   lvs_sync_daemon_interface eth1
   interface eth1
   # authentification entre les 2 machines
   authentication {
                auth_type PASS
                auth_pass secret
   }
   # définition de la vip
   virtual_ipaddress {
       192.168.60.110/32 brd 192.168.60.255 scope global
   }
   track_script {
      postgres
   }
}

