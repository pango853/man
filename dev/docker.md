
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


OR
- environment variables
	- HTTP_PROXY "http://127.0.0.1:3001"
	- HTTPS_PROXY "https://127.0.0.1:3001"
	- FTP_PROXY "ftp://127.0.0.1:3001"
	- NO_PROXY "*.test.example.com,.example2.com"
- docker run with options:
	- --env HTTP_PROXY="http://127.0.0.1:3001"
	- --env HTTPS_PROXY="https://127.0.0.1:3001"
	- --env FTP_PROXY="ftp://127.0.0.1:3001"
	- --env NO_PROXY="*.test.example.com,.example2.com
- ```~/.docker/config.json
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://127.0.0.1:3001",
     "httpsProxy": "http://127.0.0.1:3001",
     "noProxy": "*.test.example.com,.example2.com"
   }
 }
}
```


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

# Volume
```
$ docker volume create --driver vieux/sshfs \
  -o sshcmd=test@node2:/home/test \
  -o password=testpassword \
  sshvolume

$ docker run -d \
  --name sshfs-container \
  --volume-driver vieux/sshfs \
  --mount src=sshvolume,target=/app,volume-opt=sshcmd=test@node2:/home/test,volume-opt=password=testpassword \
  nginx:latest
```

Backup and restore
```
$ docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata
$ docker run -v /dbdata --name dbstore2 ubuntu /bin/bash
```

```
$ docker run --rm -v /foo -v awesome:/bar busybox top
$ docker volume prune
```

# Windows

## LinuxKit
https://github.com/linuxkit/linuxkit

## Docker on Windows
REF: https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/quick-start-windows-10

Get-WindowsOptionalFeature -Online -FeatureName *Hyper-V*
Get-WindowsOptionalFeature -Online -FeatureName *Container*

First make sure Hyper-V is enabled.
Enable-WindowsOptionalFeature -Online -FeatureName Container -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Restart-Computer -Force

https://docs.docker.com/docker-for-windows/edge-release-notes/
=> Docker Community Edition 2.0.3.0 2019-03-05 or Docker 18.09.3

 
https://master.dockerproject.org/windows/x86_64/docker.zip
https://master.dockerproject.org/windows/x86_64/docker-0.0.0-dev.zip
https://master.dockerproject.org/windows/x86_64/docker-17.06.0-dev.zip

Invoke-WebRequest "https://master.dockerproject.org/windows/x86_64/docker.zip" -OutFile "$env:TEMP\docker.zip" -UseBasicParsing
//Expand-Archive -Path "$env:TEMP\docker.zip" -DestinationPath $env:ProgramFiles
//[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
Expand-Archive -Path "$env:TEMP\docker.zip" -DestinationPath D:\DEV\
cd D:\DEV\docker

OR
Invoke-WebRequest -UseBasicParsing -OutFile dockerd.exe https://master.dockerproject.org/windows/x86_64/dockerd.exe
Invoke-WebRequest -UseBasicParsing -OutFile docker.exe https://master.dockerproject.org/windows/x86_64/docker.exe


First test:
.\dockerd.exe -D --experimental --data-root e:\var\lib\docker
dockerd.exe --experimental --debug

docker -v
Docker version master-dockerproject-2019-04-08, build f019bdca


https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon

C:\ProgramData\docker\config\daemon.json
	{
		"group" : "pango",
		"data-root": "E:\\var\\lib\\docker",
		"experimental": true,
		"debug": true
	}
sc stop docker
sc start docker
docker images

OR
sc config docker binpath= "\"C:\Program Files\docker\dockerd.exe\" --run-service -H tcp://0.0.0.0:2375"


dockerd --register-service
Start-Service Docker
OR
sc start docker
OR
net start "Docker Engine"

sc getDisplayName docker
sc query docker
sc config docker start= demand


docker pull microsoft/nanoserver
docker run -it microsoft/nanoserver cmd
	powershell.exe Add-Content C:\helloworld.ps1 'Write-Host "Hello World"'
	exit
docker commit  helloworld
docker run --rm helloworld powershell c:\helloworld.ps1

docker pull mcr.microsoft.com/windows/nanoserver:1809

docker pull mcr.microsoft.com/windows/servercore:ltsc2019
docker pull mcr.microsoft.com/windows/nanoserver:1809
docker run -it mcr.microsoft.com/windows/nanoserver:1809 cmd.exe
docker run --rm helloworld cmd.exe /s /c type Hello.txt

docker -v
docker run --rm busybox echo hello_world
docker run --rm --platform linux busybox echo hello_world
docker run --rm busybox echo hello_world


https://github.com/linuxkit/lcow

Invoke-WebRequest "https://github.com/linuxkit/lcow/releases/download/v4.14.35-v0.3.9/release.zip" -OutFile "$env:TEMP\linuxkit-lcow-release.zip" -UseBasicParsing
Remove-Item "$env:ProgramFiles\Linux Containers" -Force -Recurse
Expand-Archive "$env:TEMP\linuxkit-lcow-release.zip" -DestinationPath "$Env:ProgramFiles\Linux Containers\."
Expand-Archive  -DestinationPath ""
rm "$env:TEMP\linuxkit-lcow-release.zip"
New-Item -ItemType SymbolicLink -Path D:\DEV\docker\linuxkit-lcow -Value "$Env:ProgramFiles\Linux Containers\."
OR
New-Item -ItemType Junction -Path D:\DEV\docker\linuxkit-lcow -Value "$Env:ProgramFiles\Linux Containers\."

$env:LCOW_SUPPORTED=1
$env:LCOW_API_PLATFORM_IF_OMITTED="linux"
Remove-Item c:\lcow -Force -Recurse; mkdir c:\lcow
.\dockerd.exe -D --experimental --data-root c:\lcow

docker run -it --rm ubuntu
docker run -it --rm --platform windows microsoft/nanoserver:1709 powershell.exe

docker run -it --rm  -v E:/WS:/data alpine ls -al /data

docker run -it --rm  -v /Shared/data:/data alpine ls -al /data
docker run -it --rm  -v //Shared/data:/data alpine ls -al /data
docker run -it --rm  -v Shared/data:/data alpine ls -al /data


docker run -it --rm  -v E:\WS\docker\prom\data\prometheus.yml:/data/p.yml alpine ls -al /data
docker run -it --rm  --mount type=bind,source="E:/WS/docker/prom/data/prometheus.yml",target=/data/app.yml  alpine ls -al /data
docker: Error response from daemon: invalid volume specification: 'E:\WS\docker\prom\data\prometheus.yml:/data/p.yml': invalid mount config for type "bind": source path must be a directory.
See 'docker run --help'.

=> Solution:

docker volume create myvol1
docker volume ls

docker volume inspect myvol1
docker run -it --rm -v myvol1:/data:ro alpine ls -al /data

docker cp /tmp/my_data/. my_container:/my_data


docker volume rm myvol1


# Install Docker EE
https://bcthomas.com/2019/02/getting-started-with-linux-containers-on-windows-server-2019/

Install-Module DockerMSFTProvider
Import-Module -Name DockerMSFTProvider -Force
Import-Packageprovider -Name DockerMSFTProvider -Force
Find-Package docker
Install-Package -Name Docker -Source DockerDefault

[Environment]::SetEnvironmentVariable("LCOW_SUPPORTED", "1", "Machine")
$configfile = @"
{"experimental":true}
"@
$configfile|Out-File -FilePath C:\ProgramData\docker\config\daemon.json -Encoding ascii -Force
Invoke-WebRequest -Uri "https://github.com/linuxkit/lcow/releases/download/v4.14.35-v0.3.9/release.zip" -UseBasicParsing -OutFile release.zip
Expand-Archive release.zip -DestinationPath "$Env:ProgramFiles\Linux Containers\."
docker run --rm -it --platform=linux ubuntu bash
[Environment]::SetEnvironmentVariable("LCOW_API_PLATFORM_IF_OMITTED", "linux", "Machine")

(Optional) Install Docker Compose
$v = "1.24.0"
Invoke-WebRequest "https://github.com/docker/compose/releases/download/$v/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile D:\DEV\docker\docker-compose.exe

(Optional) Enable Remote Management of Docker Engine
$RemoteAccess = @"
{
    "hosts": ["tcp://0.0.0.0:2375", "npipe://"],
"@
$Config = Get-content C:\ProgramData\docker\config\daemon.json
$Config.Replace("{",$RemoteAccess)|Out-File -FilePath C:\ProgramData\docker\config\daemon.json -Encoding ascii -Force
Restart-Service Docker

## MSSQL
https://github.com/Microsoft/sql-server-samples/tree/master/samples/containers/replication

## Prometheus

https://docs.docker.com/config/thirdparty/prometheus/


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
