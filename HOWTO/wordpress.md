# Ubuntu 18

sudo apt-get update

sudo apt install apache2
sudo apt install mysql-server mysql-client
sudo apt install php libapache2-mod-php php-mysql php-common php-gd php-xml php-xmlrpc php-pear php-fpm unzip wget

sudo systemctl start php-fpm
	sudo systemctl start apache2
sudo systemctl start mysql

sudo mysql_secure_installation
	Set root password? [Y/n] n
	Remove anonymous users? [Y/n] y
	Disallow root login remotely? [Y/n] y
	Remove test database and access to it? [Y/n] y
	Reload privilege tables now? [Y/n] y

	New password: KLewajkfhi83q89eafyDZXVH


mysql -u root -p
	CREATE DATABASE wordpress;
	CREATE USER wordpress@localhost IDENTIFIED BY 'KL#KD%FSHOISEOXd_sklvewajH32o98';
	GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost IDENTIFIED BY 'KL#KD%FSHOISEOXd_sklvewajH32o98';
	FLUSH PRIVILEGES;
	exit


wget http://wordpress.org/latest.tar.gz
sudo rsync -avP ~/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/*

cd /var/www/html
cp wp-config-sample.php wp-config.php
vim  wp-config.php
	define( 'DB_NAME', 'wordpress' );
	define( 'DB_USER', 'wordpress' );
	define( 'DB_PASSWORD', 'KL#KD%FSHOISEOXd_sklvewajH32o98' );

touch phpinfo.php
chmod 644 phpinfo.php
vim phpinfo.php
	<?php
	// Show all information, defaults to INFO_ALL
	phpinfo();
	?>


sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

http://server_domain_name_or_IP/wp-admin
	wpadmin
	qh9i&o9jTpEI)a9bK5
	wpadmin@localhost.localhost



# Monitoring log with promtail
curl -fSL -o promtail-linux-amd64.zip "https://github.com/grafana/loki/releases/download/v1.6.1/promtail-linux-amd64.zip"
unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail
promtail --version

sudo mkdir -pv /etc/promtail/
sudo vim /etc/promtail/config-promtail.yml
```/etc/promtail/config-promtail.yml

```

sudo vim /etc/systemd/system/promtail.service
```/etc/systemd/system/promtail.service
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=promtail
ExecStart=/usr/local/bin/promtail -config.file /etc/promtail/config-promtail.yml

[Install]
WantedBy=multi-user.target
```

usermod -a -G systemd-journal promtail

sudo service promtail stop
sudo service promtail status

Loki:
	http://127.0.0.1:3100



