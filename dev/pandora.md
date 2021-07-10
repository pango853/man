

Components
	Pandora Server:
	Web console:
	Agents:
	Database:

Requirements:
	Up to 500 agents – 3GB of RAM, a 2.5GHz single-core CPU and a Hard drive with 7200 RPM.
	Up to 2.000 agents – 6GB of RAM, a dual core 2.5GHz CPU and a Hard drive with 10000 RPM or more.
	For more than 4.000 agents – 12GB of RAM, a 3GHz quad-core CPU and a Hard drive with 15000 RPM or more.


# Install Console
$ sudo yum install mariadb-server
$ sudo systemctl start mariadb
$ sudo mysql_secure_installation
$ sudo systemctl enable mariadb

sudo yum install epel-release yum-utils
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
$ sudo yum-config-manager --enable remi-php74
OR
sudo yum install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
$ sudo yum update
yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql -y

vi /etc/yum.repos.d/pandorafms.repo
	[artica_pandorafms]
	name=CentOS7 - PandoraFMS official repo
	baseurl=http://firefly.artica.es/centos7
	gpgcheck=0
	enabled=1

sudo yum -y install pandorafms_console
sudo systemctl start httpd
sudo systemctl enable httpd

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

yum install -y policycoreutils-python
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/pandora_console/include'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/pandora_console/attachment'
restorecon '/var/www/html/pandora_console/include'
restorecon '/var/www/html/pandora_console/attachment'
OR
chmod -R 777 /var/www/html/pandora_console/include

curl http://127.0.0.1/pandora_console
	user: admin
	password: pandora
rm -rf /var/www/html/pandora_console/install.php

Please note the random password generated above for later use.


# Install Server
Install dependencies before installing the Pandora server.
rpm -ivh https://sourceforge.net/projects/pandora/files/Tools%20and%20dependencies%20%28All%20versions%29/RPM%20CentOS%2C%20RHEL/wmic-4.0.0tp4-0.x86_64.rpm/download
OR wget http://softlayer-dal.dl.sourceforge.net/project/pandora/Tools%20and%20dependencies%20%28All%20versions%29/RPM%20CentOS%2C%20RHEL/wmic-4.0.0tp4-0.x86_64.rpm
rpm -ivh https://sourceforge.net/projects/pandora/files/Tools%20and%20dependencies%20%28All%20versions%29/RPM%20CentOS%2C%20RHEL/xprobe2-0.3-12.2.x86_64.rpm/download

yum -y install pandorafms_server

vi /etc/pandora/pandora_server.conf
	#dbpass pandora
	dbpass vcgujhlw

systemctl start pandora_server
systemctl start tentacle_serverd
systemctl enable pandora_server
systemctl enable tentacle_serverd

Pandora agents use tentacle protocol for sending data to Pandora server. On the Pandora server, tentacle server runs on port 41121.
firewall-cmd --zone=public --add-port=41121/tcp --permanent
firewall-cmd --reload


Go to Pandora Console –> Server –> Manager servers.

# Install Agent
curl -O https://downloads.sourceforge.net/project/pandora/Pandora%20FMS%207.0NG/746/RHEL_CentOS/pandorafms_agent_unix-7.0NG.746.noarch.rpm
yum localinstall pandorafms_agent_unix-7.0NG.709-1.noarch.rpm

vi /etc/pandora/pandora_agent.conf
server_ip 192.168.1.10
sudo systemctl start pandora_agent_daemon


# Monitoring
システム管理メニューより [エージェント管理] をクリックします。
設定したいエージェントの [モジュール] をクリックします。
[データサーバモジュールの新規作成] を選択し、[作成] をクリックします。
[ローカルコンポーネントの利用]のプルダウンメニューから、監視・情報収集したい項目を選択します。

エージェントプラグインを利用して存在する項目すべてを一気に監視項目として登録する方法もあります。
http://pandorafms.jp/Pandora_FMS_jp_library
	cd /tmp  ← load プラグインを /tmp 以下にダウンロードしていると仮定
	tar zxvf load.tar.gz
	cd load
	cp load.linux /usr/share/pandora_agent/plugins/load  ←linux用のファイルをプラグインディレクトリに、load という名前でコピー
	pandora_agent.conf に、次の設定を加えます。 (Pandora FMS Enterprise SaaS では、Pandora コンソールから実施する必要があることに注意してください。)
	module_plugin load
pandora_agent デーモンを再起動します。
pandora_agent.conf にて次のように取得したいロードアベレージの時間を指定します。
module_plugin load 1  ←1分平均のみ取得したい場合




# MISC
/usr/share/pandora_server/util/plugin
https://pandorafms.jp/download/cpu-zip/

