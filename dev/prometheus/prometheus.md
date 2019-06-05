


# Exporter

## Node exporter

> wget https://github.com/prometheus/node_exporter/releases/download/v0.18.0/node_exporter-0.18.0.linux-amd64.tar.gz
> tar zxvf node_exporter-0.18.0.linux-amd64.tar.gz
> mv node_exporter-0.18.0.linux-amd64 node_exporter
> ./node_exporter/node_exporter $OPTIONS

http://<監視対象サーバーのIPアドレス>/metricsに接続すると

## Node exporter


# Prometheus Serverの導入

> # firewall-cmd --add-port=9090/tcp --zone=public --permanent
> # firewall-cmd --reload
> # firewall-cmd --list-ports --zone=public

> wget https://github.com/prometheus/prometheus/releases/download/v2.10.0/prometheus-2.10.0.linux-amd64.tar.gz
> tar zxvf prometheus-2.10.0.linux-amd64.tar.gz
> mv prometheus-2.10.0.linux-amd64 promethus-server
> cd promethus-server
> cp prometheus.yml prometheus.yml.org


```/usr/local/src/prometheus/prometheus-server/prometheus.yml
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

/usr/local/src/prometheus/prometheus-server/prometheus \
  --config.file=/usr/local/src/prometheus/prometheus-server/prometheus.yml \

http://<プロメテウスサーバーのIPアドレス>:9090/graph

