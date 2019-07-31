%title: Postgresql
%author: xavki



# Postgresql : autorisation de connexion


<br>
* ip d'écoute : listen_adresses
		- * ou ip
		- plusieurs séparés par virgule ","
		- changement restart


<br>
* pg_hba.conf :
		- Host Based Authentication
		- /etc/postgresql/...
		- lu de haut en bas
		- reload pour prise en compte

<br>
* filtre mutlifacteurs :
		- type
		- database
		- user
		- ip/net
		- méthode d'authentification


---------------------------------------------------


# Les facteurs



<br>
* type : local ou host (distant)


<br>
* database : spécifique ou global (all)


<br>
* user : spécifique ou global (all)


<br>
* adresse : 
			- une ip, un maques de sous réseau (CIDR)
			- ipv4 ou ipv6

<br>
* méthode :
			- trust : sans login
			- peer : user de l'OS (exemple postgres)
			- password : user/password simple
			- md5 : avec chiffrement
			- reject : refus (utile en cas de maintenance)
			- ldap...

Rq : pour postgres > passwd postgres

------------------------------------------------------


# Connexions : memory


<br>
* max_connexion : 400 bytes par connexion

Rq : si elles ne sont pas établies


* connexions établies : paramètres work_mem par connexion établie



