
# Ubuntu 18

lsb_release -a

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce


sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

docker info

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -version


sudo apt-get install snmp snmpd

sudo vim /etc/snmp/snmpd.conf
```
#agentAddress udp:127.0.0.1:161,udp:192.168.43.154:161
agentAddress  udp:161

rocommunity MyCommunity 192.168.43.101

view   systemonly  included   .1.3.6.1.4.1
```

sudo systemctl restart snmpd.service
sudo systemctl status snmpd.service


snmpwalk -v2c -c public 192.168.43.154
snmpwalk -v2c -c public 127.0.0.1 ifIndex

snmptranslate -Tp
sudo apt-get install snmp-mibs-downloader
sudo download-mibs
sudo sed -i "s/^\(mibs *:\).*/#\1/" /etc/snmp/snmp.conf
sudo systemctl restart snmpd.service

snmptranslate -Tp

    CPU: .1.3.6.1.4.1.2021.11 (UCD-SNMP-MIB::systemStats)
    Memory: .1.3.6.1.4.1.2021.4 (UCD-SNMP-MIB::memory)




# Prometheus-Grafana


```docker-compose.yml
  grafana:
    image: grafana/grafana:6.7.2
    container_name: grafana
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana/provisioning:/etc/grafana/provisioning
    environment:
      - GF_SECURITY_ADMIN_USER=${ADMIN_USER}
      - GF_SECURITY_ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - GF_USERS_ALLOW_SIGN_UP=false
    restart: unless-stopped
    expose:
      - 3000
    networks:
      - monitor-net
    labels:
      org.label-schema.group: "monitoring"    
```


ADMIN_USER=admin ADMIN_PASSWORD=admin docker-compose up -d


docker ps


tree grafana/provisioning/dashboards
grafana/provisioning/dashboards
├── dashboard.yml
├── docker_containers.json
├── docker_host.json
├── monitor_services.json
└── nginx_container.json

Prometheus:
	http://<host-ip>:9090
Grafana
	http://<host-ip>:3000

# SNMP Exporter

docker inspect prom-graf-loki_snmp-exporter_1 | fgrep IPAddress
http://172.20.0.2:9116/snmp?module=if_mib&target=172.20.0.1


# Another Node
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar -zxvg node_exporter-1.0.1.linux-amd64.tar.gz
sudo mv node_exporter-1.0.1.linux-amd64 /opt/
cd /opt
sudo ln -s node_exporter-1.0.1.linux-amd64 node_exporter

```/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
#User=prometheus
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=default.target
```

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter



curl "http://172.20.0.3:9116/snmp?module=if_mib&target=172.16.4.5"


# Using file service discovery

```
scrape_configs:
  - job_name: 'node'
    file_sd_configs:
      - files:
        - 'sd_configs/prod/node_*.json'
```

```sd_configs/prod/node_targets.json
[
  {
    "targets": [ "172.16.4.5:9100" ],
    "labels": {
      "env": "dev",
      "job": "node"
    }
  }
]
```

# Using file service discovery for SNMP Exporter

```
scrape_configs:
  - job_name: 'snmp'
    scrape_interval: 200s
    scrape_timeout: 200s
    file_sd_configs:
        - files :
          - targets.yml
    metrics_path: /snmp
    params:
      module: [cisco_wlc] #which OID's we will be querying in
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: snmpexporter:9116
```
