
# Run on Docker
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

