
# Network

    -icc=trueとすると，コンテナ間のやりとりが可能になる（default）
    -icc=falseとすると，コンテナ同士は隔離される

$ docker port $ID 80
0.0.0.0:8080

--expose


docker run image --expose=3000 --expose=2000 -P
-Pでexposeした全てのportを外部公開。

docker inspect --format='{{.NetworkSettings.IPAddress}}' XXX
GWIP=`docker network inspect --format='{{(index .IPAM.Config 0).Gateway}}' bridge`


$ docker run -ti --rm --cap-add=NET_ADMIN --net=host -v /var/run/docker.sock:/var/run/docker.sock devrt/host-network-firewall


Manually port forward
	Add nat
	> iptables -t nat -A DOCKER ! -i docker0 -p tcp -m tcp --dport 8001 -j DNAT --to-destination 172.17.0.2:8888
	Add filter (default: -t filter)
	> iptables -A DOCKER -d 172.17.0.2/32 ! -i docker0 -o docker0 -p tcp -m tcp --dport 8001 -j ACCEPT

iptables rules
	- DOCKER chain		(!) Do not manipulate this table 
	- DOCKER-USER chain
		iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.1 -j DROP

Prevent Docker from manipulating iptables
	set the iptables key to false in /etc/docker/daemon.json

DockerだとホストへのアクセスがDockerに転送されるのでPREROUTING -> FORWARD -> POSTROUTINGとなる
FORWARDのなかではDOCKER-USER -> DOCKER-ISOLATION-STAGE-1 -> DOCKER-ISOLATION-STAGE-2 -> DOCKERの順にチェーンが呼ばれる。
iptables -nL -t nat
iptables -nL [-t filter]
iptables -nvL

- INPUTチェーンでルールを追加しても効かなくなる問題
Dockerを起動する前はINPUTチェーンで80ポートへの通信を社内のみに制限していたのに、起動後に80ポートへアクセスしてもINPUTチェーンではなくFORWARDチェーンを通るので社外からもアクセスできてしまう。
/sbin/iptables -I DOCKER-USER -i ens160 -p tcp --dport 80 -d 172.17.0.0/16 -s 0.0.0.0/0 -j DROP
/sbin/iptables -I DOCKER-USER -i ens160 -p tcp --dport 80 -d 172.17.0.0/16 -s 許可するIP -j ACCEPT
// 172.17.0.0/16 = `ip addr show docker0 | grep inet`で確認

OSが再起動してiptablesが元に戻ってしまうことを考慮して、Dockerのsystemd起動設定ファイルにExecStartPost=でiptablesへのルール追加を書いておくといい。

--net=hostなら、PREROUTINGで何もしていないのでINPUTチェーンに入る。
もともとINPUTチェーンで80への疎通を絞っていれば、その設定が適用される。


/etc/systemd/system/docker.service.d/docker.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd $OPTIONS
ExecStartPost=/sbin/iptables -I DOCKER -i eth0 -j DROP
ExecStartPost=/sbin/iptables -I DOCKER -i eth0 -p tcp --dport 80 -m state --state NEW -j ACCEPT

対策、
	Docker Engineの起動オプションで--iptables=false
	--net=hostでコンテナをホストのネットワークに直接繋いで、ホストのiptablesで制御する


$ iptables -I DOCKER -i ext_if ! -s 8.8.8.8 -j DROP


# MISC

## Docker Engine options
- --ip-forward=false
- --iptables=false
- --icc=true (->ACCEPT policy), --icc=false (->DROP policy)


### Exec as root,
>	$ docker exec -u 0 XXXX bash

### Proxy

	# mkdir /etc/systemd/system/docker.service.d
	# vi /etc/systemd/system/docker.service.d/http-proxy.conf
	------------------------------
	[Service]
	Environment="HTTP_PROXY=http://192.168.1.2:8080/"
	Environment="NO_PROXY=localhost,127.0.0.0/8,docker-registry.example.com"
	------------------------------
	# systemctl restart docker

## コンテナエンジンをLXC、追加でブリッジを作成しないようにする
/etc/sysconfig/docker の other_args指定に “-e lxc -b none” を追加
	other_args="-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock -e lxc -b none"

## WARNINGs
docker system info
WARNING: bridge-nf-call-iptables is disabled
WARNING: bridge-nf-call-ip6tables is disabled
WARNING: the devicemapper storage-driver is deprecated, and will be removed in a future release.
WARNING: devicemapper: usage of loopback devices is strongly discouraged for production use.
         Use `--storage-opt dm.thinpooldev` to specify a custom block storage device.

OverlayFS
cat /proc/filesystems | fgrep overlay

/etc/docker/daemon.json.
{
  "storage-driver": "overlay2"
}
$ docker info | fgrep -i storage

https://github.com/moby/moby/issues/11404

/etc/sysctl.conf
	net.bridge.bridge-nf-call-iptables = 1
	net.bridge.bridge-nf-call-ip6tables = 1
sysctl -p

# MISC
## docker-composeを使ってコンテナからホストマシンへのエイリアスを設定する
```docker-compose.yml
	version: '3'
	networks:
	  default:
	    driver: bridge
	    ipam:
	      config:
	      # ネットワークのサブネットを指定
	      - subnet: '172.30.0.0/16'
	services:
	  ping1: &ping
	    image: alpine
	    extra_hosts:
	    - dockerhost:172.30.0.1
	    command: /bin/ping -c 4 dockerhost
	  ping2: *ping
	  ping3: *ping
```
