
$ curl -G -s  "http://localhost:3100/loki/api/v1/query" --data-urlencode 'query=sum(rate({job="varlogs"}[10m])) by (level)' | jq


# Promtail

cat eventrouter.log | ./promtail -config.file promtail.yaml -dry-run

type C:\Test\test.log | promtail-windows-amd64.exe -config.file promtail-local-config.yaml -dry-run -log.level debug -stdin

```promtail-local-config.yaml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
```
