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

sudo curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


# Composing Grafana-Loki-Promtail

http://loki.dev:3100/api/prom/push
target1.dev:9080/metrics

```/etc/hosts
127.0.0.1 grafana.dev
127.0.0.1 loki.dev
127.0.0.1 target1.dev
```

## Loki
```conf/loki.yml
auth_enabled: false

server:
  http_listen_port: 3100

ingester:
  lifecycler:
    address: 0.0.0.0
    ring:
      kvstore:
        store: inmemory
      replication_factor: 1
    final_sleep: 0s
  chunk_idle_period: 5m
  chunk_retain_period: 30s
  max_transfer_retries: 0

schema_config:
  configs:
    - from: 2018-04-15
      store: boltdb
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 168h

storage_config:
  boltdb:
    directory: /tmp/loki/index

  filesystem:
    directory: /tmp/loki/chunks

limits_config:
  enforce_metric_name: false
  reject_old_samples: true
  reject_old_samples_max_age: 168h

chunk_store_config:
  max_look_back_period: 0s

table_manager:
  retention_deletes_enabled: false
  retention_period: 0s
```


## Promtail
```conf/promtail.yml
server:

  http_listen_port: 9080
  grpc_listen_port: 0

positions:

  filename: /tmp/positions.yaml

client:

  url: http://loki.dev:3100/api/prom/push

scrape_configs:

  - job_name: vlog_d
    entry_parser: raw
    static_configs:
    - targets:
        - localhost
      labels:
        job: varlog_d
        __path__: /var/log/d*.log

  - job_name: vlog_syslog
    entry_parser: raw
    static_configs:
    - targets:
        - localhost
      labels:
        job: varlog_syslog
        __path__: /var/log/syslog
```


## Now compose it!

```docker-compose.yml
version: "3"

services:
  grafana:
    image: grafana/grafana:master
    ports:
      - "3000:3000"
    networks:
      default:
        aliases:
          - grafana.dev

  loki:
    image: grafana/loki:master
    volumes:
      - /home/whoami/work/loki/conf/loki.yml:/etc/loki/local-config.yaml
    ports:
      - "3100:3100"
    networks:
      default:
        aliases:
          - loki.dev
    command: -config.file=/etc/loki/local-config.yaml

  promtail:
    image: grafana/promtail:master
    depends_on:
      - loki
    volumes:
      - /home/whoami/work/loki/conf/promtail.yml:/etc/promtail/docker-config.yaml
      - /var/log:/var/log
    command: -config.file=/etc/promtail/docker-config.yaml
    ports:
      - "9080:9080"

```

> docker-compose up -d

> curl -s loki.dev:3100/metrics
> curl -s target1.dev:9080/metrics | head -5
> web http://grafana.dev:3000
	admin:admin

> docker logs -f loki_promtail_1

> docker-compose rm -f -s -v promtail
> docker-compose up -d promtail


# Grafana dashboard configuration
Add data source: Loki
	http://loki.dev:3100
Explore Loki
	{job="varlog_syslog"}
	count_over_time({job=”varlog_syslog”}[5m])
	rate( ( {job=”varlog_syslog”} |= “error” != “timeout)[10s] ) )
	Get top 10 applications by highest log throughput:
		topk(10,sum(rate({region=”us-east1"}[5m]) by (name))
	Get the count of logs during the last 5 minutes by level:
		sum(count_over_time({job=”mysql”}[5m])) by (level)
	Get the rate of HTTP GET requests from nginx logs:
		avg(rate(({job=”nginx”} |= “GET”)[10s])) by (region)

# Webhook2FTP

## FTP Server

$ docker run -d --name ftpd_server -p 21:21 -p 30000-30009:30000-30009 -e "PUBLICHOST=localhost" -e FTP_USER_NAME=user01 -e FTP_USER_PASS=PaSsW0rd -e FTP_USER_HOME=/home/ftpusers/user01 stilliard/pure-ftpd
$ ftp -p localhost 21
	> ls
	> put test1.txt
	> put test2.txt
	> get test1.txt

## Build & go

> sudo apt-get update
> sudo apt-get install golang
> go version

> go get -u github.com/jlaffaye/ftp

```ftptest.go
package main

import (
 "github.com/jlaffaye/ftp"
 "time"
 "log"
 "io/ioutil"
 "bytes"
)


func main() {
 c, err := ftp.Dial("localhost:21", ftp.DialWithTimeout(5*time.Second))
 if err != nil {
     log.Fatal(err)
 }

 //err = c.Login("anonymous", "anonymous")
 err = c.Login("user01", "PaSsW0rd")
 if err != nil {
     log.Fatal(err)
 }

 // Do something with the FTP conn
 // Store a file
 data := bytes.NewBufferString("Hello World")
 err = c.Stor("test-file.txt", data)
 if err != nil {
  panic(err)
 }

 // Read a file
 r, err := c.Retr("test-file.txt")
 if err != nil {
  panic(err)
 }
 defer r.Close()

 buf, err := ioutil.ReadAll(r)
 println(string(buf))

 if err := c.Quit(); err != nil {
     log.Fatal(err)
 }
}
```

















docker exec -it ftpd_server /bin/bash
docker run -d \
            -p 21:21 \
            -p 21000-21010:21000-21010 \
            -e USERS="one|1234" \
            -e ADDRESS=ftp.site.domain \
            delfer/alpine-ftp-server





https://qiita.com/samskeyti/items/fbe8b78e47a5e4d6842a

├── docker-compose.yaml
├── prometheus
│   ├── alert.rules
│   └── prometheus.yaml
└── alertmanager
    └── config.yaml

```docker-compose.yaml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    volumes:
      - ./prometheus:/etc/prometheus
    command: "--config.file=/etc/prometheus/prometheus.yaml"
    ports:
      - 9090:9090
    restart: always

  exporter:
    image: prom/node-exporter:latest
    container_name: node-exporter
    ports:
      - 9100:9100
    restart: always

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - 3000:3000
    restart: always

  alertmanager:
    image: prom/alertmanager
    container_name: alertmanager
    volumes:
      - ./alertmanager:/etc/alertmanager
    command: "--config.file=/etc/alertmanager/config.yaml"
    ports:
      - 9093:9093
    restart: always
```

```prometheus/prometheus.yaml
global:
  scrape_interval:     15s 
  evaluation_interval: 15s 
  external_labels:
      monitor: 'codelab-monitor'

rule_files:
  - /etc/prometheus/alert.rules

alerting:
  alertmanagers:
    - scheme: http
      static_configs:
      - targets:
        - alertmanager:9093

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets:
        -  prometheus:9090
        -  node-exporter:9100
```

```prometheus/alert.rules
groups:
- name: example
  rules:
  - alert: instance_down
    expr: up == 0
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "Instance {{ $labels.instance }} down",
      description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes."
```


```alertmanager/config.yaml
#global:
#  slack_api_url: 'https://hooks.slack.com/services/***/***/******'

#route:
#  receiver: 'slack'

#receivers:
#  - name: 'slack'
#    slack_configs:
#    - channel: '#alerts'
route:
  receiver: dummy

receivers:
  - name: dummy
```


> curl -H "Content-Type: application/json" -d '[{"status": "firing", "labels":{"alertname":"TestAlert1"}}]' localhost:9093/alertmanager/api/v1/alerts

Data SourcesにPrometheusを選択すると下の画面が表示されますが、HTTPのURLにhttp://pormetheus.dev:9090、AccessにServerを選択しSave&Testボタンを押せば設定完了です。
DashboardsタブからPrometheus 2.0 Statsをimportします。


exporter:
	http://127.0.0.1:9100/metrics


node_filesystem_avail_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hostname"} 2.7395301376e+10
node_filesystem_avail_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hosts"} 2.7395301376e+10
node_filesystem_avail_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/resolv.conf"} 2.7395301376e+10
node_filesystem_free_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hostname"} 2.7412078592e+10
node_filesystem_free_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hosts"} 2.7412078592e+10
node_filesystem_free_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/resolv.conf"} 2.7412078592e+10

node_filesystem_size_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hostname"} 3.1036686336e+10
node_filesystem_size_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hosts"} 3.1036686336e+10
node_filesystem_size_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/resolv.conf"} 3.1036686336e+10




1 - node_filesystem_avail_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hostname"} / node_filesystem_size_bytes{device="/dev/sda1",fstype="ext4",mountpoint="/etc/hostname"}
dd if=/dev/zero of=1g.bin bs=1G count=1


http://172.19.0.1:3333/sms?to=0176883680
http://172.19.0.1:3333/sms?to=0176883680&0176543210



2020/06/02 08:34:29 Webhook: {
	Message:Someone is testing the alert notification within Grafana.
	RuleName:Test notification
	State:alerting
	Title:[Alerting] Test notification 
	EvalMatches:[
		{
			Value:100
			Metric:High value 
			Tags:map[]
		}
		{Value:200 Metric:Higher Value Tags:map[]}]}
2020/06/02 08:34:01 Webhook: {
	Message:Testing Message...Last line.
	RuleName:Freespace alert
	State:alerting
	Title:[Alerting] Freespace alert
	EvalMatches:[
		{
			Value:0.18683620954966107
			Metric:{device="/dev/sda1", fstype="ext4", instance="node-exporter:9100", job="prometheus", mountpoint="/etc/hostname"}
			Tags:map[mountpoint:/etc/hostname device:/dev/sda1 fstype:ext4 instance:node-exporter:9100 job:prometheus]}]}
2020/06/02 08:36:01 Webhook: {
	Message:Testing Message...Last line.
	RuleName:Freespace alert
	State:ok
	Title:[OK] Freespace alert EvalMatches:[]}
EvalMatches



const ENV_MY_PORT = "MY_PORT"
const ENV_FTP_URL = "FTP_URL"
const ENV_FTP_USER = "FTP_USER"
const ENV_FTP_PASS = "FTP_PASS"
const ENV_SMS_DEPT = "SMS_DEPT"
const ENV_SMS_SECT = "SMS_SECT"

MY_PORT=3333 FTP_URL=localhost:21 FTP_USER=user01 FTP_PASS=PaSsW0rd SMS_DEPT=ITG SMS_SECT=ADSD SMS_TPID=AT001 ./sendsms


        EvalMatches []WHEvalMatch `json:"evalMatches"`
 33 }
 34 type WHEvalMatch struct {
 35         Value   float64       `json:"value"`
 36         Metric  string        `json:"metric"`
 37         Tags    map[string]string   `json:"tags"`
 38 }



0176883680|ADSD|ITG|AT001|Title|Message|Metric name|1.001|


ftp_url := "localhost:21"
ftp_user := "user01"
ftp_pass := "PaSsW0rd"


$ docker run -d --name ftpd_server -p 21:21 -p 30000-30009:30000-30009 -e "PUBLICHOST=localhost" -e FTP_USER_NAME=user01 -e FTP_USER_PASS=PaSsW0rd -e FTP_USER_HOME=/home/ftpusers/user01 stilliard/pure-ftpd

0176883680|ADSD|ITG|AT001|Title|Message|Metric name|1.001|
