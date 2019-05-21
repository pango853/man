
docker run -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
docker run -p 9090:9090 -v /prometheus-data prom/prometheus --config.file=/prometheus-data/prometheus.yml



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