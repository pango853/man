
# Example 1

$ docker run --rm \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong kong migrations bootstrap

$ docker run -d --name kong \
    --link kong-database:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
    -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
    -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
    -p 8000:8000 \
    -p 8443:8443 \
    -p 8001:8001 \
    -p 8444:8444 \
    kong

$ docker exec -it kong kong reload

# Example 2

docker network create kong-net

docker run -d --name kong-database \
               --network=kong-net \
               -p 9042:9042 \
               cassandra:3
OR
docker run -d --name kong-database \
               --network=kong-net \
               -p 5432:5432 \
               -e "POSTGRES_USER=kong" \
               -e "POSTGRES_DB=kong" \
               -e "POSTGRES_PASSWORD=kong" \
               postgres:9.6

docker run --rm \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     kong:latest kong migrations bootstrap

docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_PG_PASSWORD=kong" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 8001:8001 \
     -p 8444:8444 \
     kong:latest

curl -i http://localhost:8001/

# Configuration

1. Add your Service using the Admin API

$ curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=example-service' \
  --data 'url=http://mockbin.org'


2. Add a Route for the Service
$ curl -i -X POST \
  --url http://localhost:8001/services/example-service/routes \
  --data 'hosts[]=example.com'

3. Forward your requests through Kong
$ curl -i -X GET \
  --url http://localhost:8000/ \
  --header 'Host: example.com'

# Example 3
```docker-compose.yml
version: '2'
services:
  kong_vol:
    image: busybox
    volumes:
      - /var/lib/postgresql/data

  kong-database:
    image: postgres:9.4
    environment:
      - POSTGRES_USER=kong
      - POSTGRES_DB=kong
    volumes_from:
      - kong_vol

  kong-migration:
    image: kong
    depends_on:
      - kong-database
    environment:
      - KONG_DATABASE=postgres
      - KONG_PG_HOST=kong-database
    command: kong migrations up

  kong:
    image: kong:latest
    depends_on:
      - kong-database
      - kong-migration
    environment:
      - KONG_DATABASE=postgres
      - KONG_PG_HOST=kong-database
      - KONG_PG_DATABASE=kong
    ports:
     - "8000:8000"
     - "8443:8443"
     - "8001:8001"
     - "8444:8444"
```



# Usage

REF: https://getkong.org/docs/0.11.x/admin-api/

- API一覧表示
  GET：/apis/

- API情報の取得
  GET：/apis/{name or id}

- APIの登録
  POST：/apis/
	name	APIの一意な名前
	uris	APIの一意なURL。このURIが指定されたときにこのAPIが呼ばれる。
	upstream_url	APIが呼ばれたときに実行されるAPI

- APIの削除
  DELETE：/apis/{name or id}

