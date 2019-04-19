Consul とは
インフラ上のサービス設定とサービスディスカバリのためのツール

- 機能 ◦サービス・ディスカバリとオーケストレーション
  - ヘルスチェック
  - キーバリュー・ストア
  - 耐障害性
- Consul Template で定型処理の簡易化


# Install

```
$ wget -O consul.zip https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip
$ unzip consul.zip
$ ./consul version
	Consul v0.6.4
	Consul Protocol: 3 (Understands back to: 1)
$ nohup consul agent -server \
    -data-dir="/tmp/consul" \
    -bootstrap-expect 1 \
    -node=consul1 \
    -config-dir=/etc/consul.d &
$ ./consul members

$ consul join <ノード> <ノード>

$ consul members

```

```web.json
{
  "service": {
    "name": "web",
    "tags": [ "httpd" ],
    "port": 80,
    "check": {
      "script": "curl localhost:80 >/dev/null 2>&1",
      "interval": "10s"
    }
  },
  "key": "web",
  "handler": "/opt/consul/consul-handler.sh"
}
```

```
	$ curl http://127.0.0.1:8500/v1/catalog/nodes

	$ dig @127.0.0.1 -p 8600 web.zem.jp.node.consul


	$ consul watch –http-addr=127.0.0.1:8500 \
    	-type=service \
    	–service=mysql \
    	/opt/action.sh

```


# Consul Template

REF: https://github.com/hashicorp/consul-template

- consul のイベントを監視するデーモン
- 状況変化が発生すると ◦テンプレートを読み込む 
- サービス・ディスカバリの状態をファイルに反映
- 任意コマンドの実行（オプション）

```
	$ sudo yum -y install git golang
	$ export GOPATH=/usr/local/src/go
	$ git clone https://github.com/hashicorp/consul-template.git
	$ cd consul-templae
	$ make
	$ sudo cp ./bin/consul-template /usr/bin/
	$ consul-template --version
	consul-template v0.7.1.dev
```

```host-node.tmpl
	# consul nodes{{range nodes}}
	{{.Address}}    {{.Node}}{{end}}
```

```
	$ consul-template -consul <Consulサーバ>:<HTTP port> \
		-template "テンプレートのファイル名:出力先:コマンド(オプション)" \
		-template "同上" (オプション) \
		-dry (オプション)
```

```/etc/hosts
	# consul nodes
	192.168.39.3    sion.pocketstudio.net
	192.168.39.11    web1
	192.168.39.12    web2
```

```nginx
	upstream frontend { {{range service "web"}}
		server {{.Address}}:{{.Port}};{{end}}
	}

	server {
		listen 80 default_server;
		location / {
			proxy_pass http://frontend;
		}
	}
```
