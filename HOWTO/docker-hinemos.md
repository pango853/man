
# Try it on GCP Debian 9

ZONE=asia-southeast1-b
gcloud compute instances create test-docker --machine-type n1-standard-2 --boot-disk-size=20GB --zone $ZONE --maintenance-policy=TERMINATE
gcloud compute ssh test-docker --zone $ZONE
	useradd -s /bin/bash -d /home/aaa -g aaa -G aaa,google-sudoers -m aaa

sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
sudo usermod -aG docker ${USER}
sudo su - ${USER}

docker run --rm -it -d -p 24001:24001 pango853/hinemos-db:6.2.2-alpha
docker run --rm -it -d -e DB_HOST=172.17.0.2 -p 8080:8080 -p 8081:8081 pango853/hinemos-manager:6.2.2-alpha
docker run --rm -d -p 9090:80 pango853/hinemos-web:6.2.2-alpha


# Problems

## syslog
```
[root@c4de27314ffa /]# rpm -ivh https://github.com/hinemos/hinemos/releases/download/v6.2.2/hinemos-6.2-agent-6.2.2-1.el.noarch.rpm
Retrieving https://github.com/hinemos/hinemos/releases/download/v6.2.2/hinemos-6.2-agent-6.2.2-1.el.noarch.rpm
Preparing...                          ################################# [100%]
Updating / installing...
   1:hinemos-6.2-agent-0:6.2.2-1.el   ################################# [100%]
/etc/rsyslog.conf and /etc/syslog.conf are not found. Please edit System Logger configuration reffering the Manual
```

## No LOG!!!
```
docker run --rm -it hinemos/hinemos-agent:6.2.2-alpha
// Show nothing!!!
```

## Failed to init 
```
[root@6bf582268c09 sbin]# cat ~/install.log.hinemos_manager
Because environment variable LANG is ,
the DB language is en.

file systems mounted
/dev/sda1 - /etc/hosts
database directory(/opt/hinemos/var/data) will be in partition ( / ).
file system contains log directory(/opt/hinemos/var/log) will be in partition ( / ).

Configuring files (hinemos.cfg, postgresql.conf, persistence.xml, selfcheck-service.properties)...Change of /etc/snmp/snmpd.conf is not required.
[OK]

Changing the permissions of files...[OK]

Initializing internal database...
checking database directory(/opt/hinemos/var/data)... done
checking current user(hinemos)... done
initializing database directory(/opt/hinemos/var/data)... done
...
```

CAUSE: LANGUAGE is empty
       > su -c "${HINEMOS_HOME}/sbin/db_init/pg_init.sh ${LANGUAGE}" - ${HINEMOS_OS_USER} >> ~/install.log.hinemos_manager 2>&1
SOLUTION: LANGUAGE rpm -ivh ...
