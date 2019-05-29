
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