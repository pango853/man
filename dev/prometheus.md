
docker run -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
docker run -p 9090:9090 -v /prometheus-data prom/prometheus --config.file=/prometheus-data/prometheus.yml

# Run on Ubuntu

```
 # wget https://github.com/prometheus/node_exporter/releases/download/v0.18.0/node_exporter-0.18.0.linux-amd64.tar.gz
 # tar zxvf node_exporter-0.18.0.linux-amd64.tar.gz
 # mv node_exporter-0.18.0.linux-amd64 node_exporter

 Try:
 # nohup ./prometheus/node_exporter/node_exporter > /tmp/node_exporter.log 2>&1&
 # echo $! > /tmp/node_exporter.pid
 # kill -9 `cat /tmp/node_exporter.pid`

 # vim /usr/lib/systemd/system/prometheus-node-exporter.service
	### See below ###
 # systemctl daemon-reload
 # systemctl enable prometheus-node-exporter.service
 # systemctl start prometheus-node-exporter.service

 # firewall-cmd --add-port=9100/tcp --zone=public --permanent
 # firewall-cmd --reload
 # firewall-cmd --list-ports --zone=public

 # curl http://<監視対象サーバーのIPアドレス>/metrics


 # wget https://github.com/prometheus/prometheus/releases/download/v2.10.0/prometheus-2.10.0.linux-amd64.tar.gz
 # tar zxvf prometheus-2.10.0.linux-amd64.tar.gz
 # mv prometheus-2.10.0.linux-amd64 server
 # cd promethus-server
 # cp prometheus.yml prometheus.yml.org
 # vim prometheus.yml
	### SEE BELOW ###

 Try:
 # nohup ./prometheus/server/prometheus --config.file=./prometheus/server/prometheus.yml > /tmp/prometheus.log 2>&1&
 # echo $! > /tmp/prometheus.pid
 # kill -9 `cat /tmp/prometheus.pid`

 # vim /usr/lib/systemd/system/prometheus.service
	### See below ###
 # systemctl daemon-reload
 # systemctl enable prometheus.service
 # systemctl start prometheus.service

 # firewall-cmd --add-port=9090/tcp --zone=public --permanent
 # firewall-cmd --reload
 # firewall-cmd --list-ports --zone=public

 # curl http://<監視対象サーバーのIPアドレス>/metrics
```



```/usr/lib/systemd/system/prometheus-node-exporter.service
[Unit]
Description=Node Exporter
Documentation=https://github.com/prometheus/node_exporter

[Service]
Type=simple
ExecStart=EnvironmentFile=/usr/local/src/prometheus/node_exporter/node_exporter $OPTIONS
Restart=always

[Install]
WantedBy=multi-user.target
```

```/usr/local/src/prometheus/prometheus/prometheus.yml
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets:
        - '192.168.0.2:9100'
```

```/usr/lib/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
 
[Service]
#User=prometheus
#Group=prometheus
Type=simple
ExecStart=/usr/local/src/prometheus/prometheus/prometheus \
  --config.file=/usr/local/src/prometheus/prometheus/prometheus.yml
#    --config.file /etc/prometheus/prometheus.yml \
#    --storage.tsdb.path /var/lib/prometheus/ \
#    --web.console.templates=/etc/prometheus/consoles \
#    --web.console.libraries=/etc/prometheus/console_libraries
 
[Install]
WantedBy=multi-user.target
```


# Run on Docker

## Images
- prom/prometheus   
  prometheusはみんなだいすきSoundCloudが中心となってGo言語で開発されている監視ツールです。
  有名なZabbixなどはpush型の監視ですが、prometheusはpull型のシステムです。設定でサービスディスカバリを記述してあげると、あとは良い感じにデータを拾って来てくれます。
- prom/node-exporter   
  node-exporterはホストの状態を取得するexporterです。
- google/cadvisor   
  cadvisorがgoogleが開発している、dokerコンテナの情報を取得するexporterです。
  これ単品でもdokcerコンテナを監視することは出来ますが、今回はデータをprometheusで一括監視するために使用します。
- grafana/grafana   
  prometheusからの情報を簡単で良い感じに視覚化してくれるツールです。

## Preparation
Docker and docker-compose
	https://docs.docker.com/docker-for-xxx/install/
	sudo pip install docker-compose
## Start
docker-compose -f docker-compose.yml up

- Prometheus: http://localhost:9090/
- Grafana: http://localhost:3000/

## Setup
1. Add organization
2. Add Data Sources
	- Type: Prometheus	Url: http://localhost:9090/
	- Also import Dashboards
3. Add exporter
https://github.com/prometheus/node_exporter

4. Restart
docker-compose up -d

## Targets
Check if Prometheus - exporter  is UP.
http://localhost:9090/targets

## graph

# Usage

docker pull prom/prometheus-cli
docker run --rm -ti prom/prometheus-cli -server "http://172.22.6.130:9090/" metrics
Usage:
  ./prometheus_cli [flags] query <expression>
  ./prometheus_cli [flags] query_range <expression> <end_timestamp> <range_seconds> [<step_seconds>]
  ./prometheus_cli [flags] metrics

Error querying server: invalid character 'N' looking for beginning of value