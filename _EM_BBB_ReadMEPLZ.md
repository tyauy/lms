# Install a TURN server for BigBlueButton

1. Make a backup of the BBB properties on the 'old' server

2. Install the necessary dependencies on the turn server 
sudo apt-get install coturn

3. Edit the TURN server configuration file (usually located at `/etc/turnserver.conf`) and make the following changes:
* Set the listening port (e.g., `listening-port=3478`).
* Set the TURN server URL (e.g., `external-ip=your-server-ip`). 
* Set the authentication mechanism: `use-auth-secret`.
* Set the shared secret: `static-auth-secret=your-secret)`.
* `tls-listening-port=443`
* `fingerprint`
* `lt-cred-mech: no bc auth-secret`
* `realm=wefitgroup.com`
* `cert=/etc/letsencrypt/live/XXX.wefitgroup.com/fullchain.pem`
* `pkey=/etc/letsencrypt/live/XXX.wefitgroup.com/privkey.pem`
* Your cert will expire on 2023-05-16. To obtain a new or tweaked version of this certificate in the future, simply run certbot again. To non-interactively renew *all* of your certificates, run "certbot renew"
* `cipher-list="ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384"`
* `dh-file=/etc/turnserver/dhp.pem`
* `no-multicast-peers`
* `no-loopback-peers` (kept commented bc conflicting with other config decisions according to this command : `turnserver --daemon -c /etc/turnserver.conf --pidfile /run/turnserver.pid`)

4. Generate SSL certificate

* sudo openssl req -x509 -newkey rsa:4096 -keyout /etc/turnserver/turn_server_pkey.pem -out /etc/turnserver/turn_server_cert.pem -days 365 -nodes
* sudo certbot certonly --standalone --preferred-challenges http -d XXX.wefitgroup.com
* sudo certbot certonly --standalone --preferred-challenges http -d XXX.wefitgroup.com XXX@wefitgroup.com

* Your certificate and chain have been saved at: `/etc/letsencrypt/live/XXX.wefitgroup.com/fullchain.pem
* Your key file has been saved at: `/etc/letsencrypt/live/XXX.wefitgroup.com/privkey.pem

5. Create the deploy/coturn file
* nano deploy/coturn
* #!/bin/bash -e
for certfile in fullchain.pem privkey.pem ; do
	cp -L /etc/letsencrypt/live/XXX.wefitgroup.com/"${certfile}" /etc/turnserver/"${certfile}".new
	chown turnserver:turnserver /etc/turnserver/"${certfile}".new
	mv /etc/turnserver/"${certfile}".new /etc/turnserver/"${certfile}"
done
systemctl kill -sUSR2 coturn.service

6. Configure Log rotation

* nano etc/logrotate.d/coturn
* /var/log/turnserver/*.log
{
	rotate 7
	daily
	missingok
	notifempty
	compress
	postrotate
		/bin/systemctl kill -s HUP coturn.service
	endscript
}

7. Start the TURN server

* sudo turnserver

8. Test the TURN server 

* Using a turn client: https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/
* Using Firefox: go in about:config then switch media.peerconnection.ice.relay_only to true


9. In the BBB server in turn-stun-servers.xml

<pre><code>``` <bean id="stunTurnServers" class="org.bigbluebutton.web.services.turn.StunTurnServers">
<property name="stunServers">
<list>
<value>stun:stun.l.google.com:19302</value>
</list>
</property>
<property name="turnServers">
<list>
<value>turn:TURN_SERVER_IP:TURN_SERVER_PORT?transport=udp</value>
<value>turn:TURN_SERVER_IP:TURN_SERVER_PORT?transport=tcp</value>
</list>
</property>
<property name="turnUsername" value="TURN_USERNAME"/>
<property name="turnCredential" value="TURN_PASSWORD"/>
</bean> ```</code></pre>

10. Restart BigBlueButton

* sudo bbb-conf –restart

# Conf we ran for V4

## Feb 23

wget -qO- https://ubuntu.bigbluebutton.org/bbb-install-2.5.sh | bash -s -- -v focal-250 -s visio2.wefitgroup.com -e AAA@wefitgroup.com -w -g -a 

## Create admins
* docker exec greenlight-v2 bundle exec rake user:create["WA","RRR@wefitgroup.com","XXX","admin"]
* docker exec greenlight-v2 bundle exec rake user:create["E","EEE@wefitgroup.com","XXX","admin"]

# Conf for V3


* iptables -A INPUT -p UDP  --match multiport --dports 32769:65535 -j ACCEPT
* wget -qO- https://ubuntu.bigbluebutton.org/bbb-install-2.5.sh | bash -s -- -c XXX.wefitgroup.com:YYY -e AAA@wefitgroup.com

# Changing server config to allow root connection
* https://docs.ovh.com/gb/en/vps/root-password/#step-3-chroot-permissions_1
* sudo passwd root 
* nano /etc/ssh/sshd_config
* Add the following line: PermitRootLogin yes
* systemctl restart sshd

# Useful Terminal Commands

## Turn

* `sudo systemctl status coturn`
* `sudo systemctl start coturn`
* `turnserver --daemon -c /etc/turnserver.conf --pidfile /run/turnserver.pid`

## BBB

* `sudo bbb-conf --status`
* `dpkg -l | grep bbb-`
* `sudo bbb-conf --secret`
* `bbb-conf --check`
* `bbb-conf –lti`
* `sudo bbb-conf --start`
* `sudo bbb-conf --stop`
* `sudo ufw status`
* `sudo ufw allow 1234/udp`
* `sudo find / -name "bigbluebutton*"`

# To migrate DB

> https://blog.wirelessmoves.com/2021/05/upgrading-to-bbb-v2-3-and-ubuntu-18-04.html
> https://sandstorm.de/de/blog/post/migration-of-greenlight-and-big-blue-button.html


## On the server you want the data from
1. cd ~/greenlight
2. docker exec greenlight_db_1 /usr/bin/pg_dumpall -U postgres -f /var/lib/postgresql/data/dump.sql
3. Delete the following two lines at the beginning of the dump file:
* CREATE ROLE postgres;
* ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'xxxxxxxxxxxxxx';

## On the new server

 ** the following commands reset your DB !!! all existing data is lost !!! **
1.	cd /root/greenlight/
2.	docker-compose stop app
3.	docker-compose exec db bash
4.	psql --username=postgres
5.	DROP DATABASE greenlight_production;
6.	CREATE DATABASE greenlight_production;
7.	\q
8.	psql \
9.	  --dbname=greenlight_production \
10.	  --username=postgres \
11.	  < /var/lib/postgresql/data/db.sql
12.	rm /var/lib/postgresql/data/db.sql
13.	exit
14. docker cp ../dump.sql greenlight_db_1 : /
15. docker-compose start app


# For help on forums, run the following commands:

* `sudo bbb-conf --check`
* `cat /usr/share/bbb-web/WEB-INF/classes/spring/turn-stun-servers.xml`
* Log of about:webrtc in Firefox
* Or Chrome chrome://webrtc-internals/

## Issue description:

* Did the same test scenario work on https://test.bigbluebutton.org? 
* Please state if this is happening consistently or intermittently
* Please state which browser, device and OS (with versions) you're seeing it on
* Please explain if your server is behind NAT. If possible, which type of NAT. The more details, the better.
