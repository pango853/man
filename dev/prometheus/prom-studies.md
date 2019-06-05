
# Write some rules

```prometheus.yml
rule_files:
  - 'prometheus.rules.yml'
```

## Recording Rules
```prometheus.rules.yml
	groups:
	  - name: recording_rules
		rules:
		  - record: node_exporter:node_memory_free:memory_used_percents
			expr: 100 - 100 * (node_memory_MemFree / node_memory_MemTotal)

groups:
  - name: recording_rules
    interval: 5s
    rules:
      - record: node_exporter:node_filesystem_free:fs_used_percents
        expr: 100 - 100 * ( node_filesystem_free{mountpoint="/"} / node_filesystem_size{mountpoint="/"} )

      - record: node_exporter:node_memory_free:memory_used_percents
        expr: 100 - 100 * (node_memory_MemFree / node_memory_MemTotal)
```
## Alert Rules
```
groups:
  - name: alerting_rules
  rules:
    - alert: LoadAverage15m
      expr: node_load15 >= 0.75
      labels:
        severity: major
      annotations:
        summary: "Instance {{ $labels.instance }} - high load average"
        description: "{{ $labels.instance  }} (measured by {{ $labels.job }}) has high load average ({{ $value }}) over 15 minutes."

groups:
  - name: recording_rules
    interval: 5s
    rules:
      - record: node_exporter:node_filesystem_free:fs_used_percents
        expr: 100 - 100 * ( node_filesystem_free{mountpoint="/"} / node_filesystem_size{mountpoint="/"} )

      - record: node_exporter:node_memory_free:memory_used_percents
        expr: 100 - 100 * (node_memory_MemFree / node_memory_MemTotal)

  - name: alerting_rules
    rules:
      - alert: LoadAverage15m
        expr: node_load15 >= 0.75
        labels:
          severity: major
        annotations:
          summary: "Instance {{ $labels.instance }} - high load average"
          description: "{{ $labels.instance  }} (measured by {{ $labels.job }}) has high load average ({{ $value }}) over 15 minutes."

      - alert: MemoryFree10%
        expr: node_exporter:node_memory_free:memory_used_percents >= 90
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Instance {{ $labels.instance }} hight memory usage"
          description: "{{ $labels.instance }} has more than 90% of its memory used."

      - alert: DiskSpace10%Free
        expr: node_exporter:node_filesystem_free:fs_used_percents >= 90
        labels:
          severity: moderate
        annotations:
          summary: "Instance {{ $labels.instance }} is low on disk space"
          description: "{{ $labels.instance }} has only {{ $value }}% free."
```

> promtool check rules /etc/prometheus/prometheus.rules.yml


Query:
node_exporter:node_filesystem_free:fs_used_percents


# Write some queries
{instance="localhost:9090"}
{job="prometheus"}
up{instance="localhost:9090",job="prometheus"}

node_memory_Active[5m] offset 1h


# Monitoring RabbitMQ


For RabbitMQ:

sudo apt-key adv --keyserver "hkps.pool.sks-keyservers.net" --recv-keys "0x6B73A36E6026DFCA"
sudo apt-get install apt-transport-https
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution erlang-21.x
deb https://dl.bintray.com/rabbitmq/debian $distribution main
EOF

sudo apt-get update -y
sudo apt-get install rabbitmq-server -y --fix-missing

sudo systemctl status rabbitmq-server.service
sudo systemctl start rabbitmq-server.service
sudo journalctl --system | grep rabbitmq


For CentOS 7:

```/etc/yum.repos.d/rabbitmq.repo
[bintray-rabbitmq-server]
name=bintray-rabbitmq-rpm
baseurl=https://dl.bintray.com/rabbitmq/rpm/rabbitmq-server/v3.7.x/el/7/
gpgcheck=0
repo_gpgcheck=0
enabled=1
```

```
yum install rabbitmq-server
```
OR
```
rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
yum install rabbitmq-server-3.7.15-1.el7.noarch.rpm
```

rabbitmq-plugins list
rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server.service

curl http://localhost:15672
	guest/guest

Add user: /etc/rabbitmq/rabbitmq.congif > loopback_users
systemctl restart rabbitmq-server.service
OR
```
# rabbitmqctl add_user {ユーザ名} {パスワード}
$ rabbitmqctl add_user admin ********

# rabbitmqctl set_user_tags {ユーザ名} {ロール}
$ rabbitmqctl set_user_tags admin administrator

# rabbitmqctl set_permissions {ユーザ名} {設定変更} {書き込み} {読み込み}
$ rabbitmqctl set_permissions admin '.*' '.*' '.*'
$ rabbitmqctl delete_user guest
```



mkdir -p /usr/lib/rabbitmq/plugins
cd /usr/lib/rabbitmq/plugins

# Downloads prometheus_rabbitmq_exporter and its dependencies with curl

readonly base_url='https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.4'

get() {
  curl -LO "$base_url/$1"
}

get accept-0.3.3.ez
get prometheus-3.5.1.ez
get prometheus_cowboy-0.1.4.ez
get prometheus_httpd-2.1.8.ez
get prometheus_rabbitmq_exporter-3.7.2.4.ez


sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/accept-0.3.5.ez
sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/prometheus-4.3.0.ez
sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/prometheus_cowboy-0.1.7.ez
sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/prometheus_httpd-2.1.10.ez
sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/prometheus_process_collector-1.4.3.ez
sudo curl -LO https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.9.1/prometheus_rabbitmq_exporter-3.7.9.1.ez



rabbitmq-plugins enable prometheus_rabbitmq_exporter
curl --verbose http://localhost:15672/api/metrics

rabbitmqctl environment | grep collect_statistics_interval


```Prometheus config file:
scrape_configs:
  - job_name: rabbitmq
    scrape_interval: 5s
    scrape_timeout: 4s
    metrics_path: /api/metrics
    static_configs:
      - targets: ['localhost:15672']
```

curl http://localhost:9090/graph?g0.range_input=1h&g0.expr=rabbitmq_exchanges&g0.tab=0:


# https://github.com/ncabatoff/process-exporter

wget https://github.com/ncabatoff/process-exporter/releases/download/v0.5.0/process-exporter-0.5.0.linux-amd64.tar.gz
process-exporter [options] -config.path myprocess.yml

curl http://localhost:9256/metrics

```myprocess.yml
process_names:
  # comm is the second field of /proc/<pid>/stat minus parens.
  # It is the base executable name, truncated at 15 chars.
  # It cannot be modified by the program, unlike exe.
  - comm:
    - bash

  # exe is argv[0]. If no slashes, only basename of argv[0] need match.
  # If exe contains slashes, argv[0] must match exactly.
  - exe:
    - postgres
    - /usr/local/bin/prometheus

  # cmdline is a list of regexps applied to argv.
  # Each must match, and any captures are added to the .Matches map.
  - name: "{{.ExeFull}}:{{.Matches.Cfgfile}}"
    exe:
    - /usr/local/bin/process-exporter
    cmdline:
    - -config.path\s+(?P<Cfgfile>\S+)
```

# blackbox exporter

wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.14.0/blackbox_exporter-0.14.0.linux-amd64.tar.gz

./blackbox_exporter --config.file blackbox.yml
```blackbox.yml
modules:
  http_2xx:
    prober: http
    http:
  http_post_2xx:
    prober: http
    http:
      method: POST
  tcp_connect:
    prober: tcp
  pop3s_banner:
    prober: tcp
    tcp:
      query_response:
      - expect: "^+OK"
      tls: true
      tls_config:
        insecure_skip_verify: false
  ssh_banner:
    prober: tcp
    tcp:
      query_response:
      - expect: "^SSH-2.0-"
  irc_banner:
    prober: tcp
    tcp:
      query_response:
      - send: "NICK prober"
      - send: "USER prober prober prober :prober"
      - expect: "PING :([^ ]+)"
        send: "PONG ${1}"
      - expect: "^:[^ ]+ 001"
  icmp:
    prober: icmp
```

curl http://127.0.0.1:9115/metrics
curl http://localhost:9115/probe?target=127.0.0.1:22&module=ssh_banner
curl http://localhost:9115/probe?target=127.0.0.1:9090&module=http_2xx

https://www.robustperception.io/checking-for-http-200s-with-the-blackbox-exporter

# SNMP exporter

TODO

sudo apt-get install build-essential libsnmp-dev snmp-mibs-downloader
go get github.com/prometheus/snmp_exporter/generator
cd ${GOPATH-$HOME/go}/src/github.com/prometheus/snmp_exporter/generator
go build

