

# Setup From Docker on Windows



docker run --name some-redis -d redis
docker run --name some-redis -d redis redis-server --appendonly yes

docker run -it --network some-network --rm redis redis-cli -h some-redis

