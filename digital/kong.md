





docker@bookmark:~$ docker run -d --name kong \
              --link kong-database:kong-database \
              -e "DATABASE=cassandra" \
              -p 80:8000 \
              -p 8443:8443 \
              -p 8001:8001 \
              -p 7946:7946 \
              -p 7946:7946/udp \
              --security-opt seccomp:unconfined \
              mashape/kong


$ curl http://$(docker-machine ip bookmark):8001/apis
{"data":[],"total":0} # ← これが帰ってくれば成功


curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'name=yahoo' \
  --data 'upstream_url=http://www.yahoo.co.jp/' \
  --data 'strip_request_path=true' \
  --data 'request_path=/yahoo' --data 'request_host=www.yahoo.co.jp'

curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'name=qiita' \
  --data 'upstream_url=http://qiita.com/' \
  --data 'strip_request_path=true' \
  --data 'request_path=/qiita' --data 'request_host=qiita.com'
  
  
  


$ echo "$(echo $(docker-machine ip bookmark))  bookmark" | \
  sudo tee -a /etc/hosts

ブラウザでbookmark/qiitaを開く
ブラウザでbookmark:8081/apisを開く


# Konga

~$ sudo yum install epel-release
~$ sudo yum install npm
~$ sudo npm install bower gulp sails -g
~$ sudo yum install git
~$ git clone git://github.com/creationix/nvm.git ~/.nvm
~$ source ~/.nvm/nvm.sh
~$ nvm install 9.0.0
~$ nvm use 9.0.0

~$ git clone https://github.com/pantsel/konga.git
~$ cd konga
~$ npm install

~$ cd config
~$ cp -pr local_example.js local.js
~$ vi local.js
	- // kong_admin_url : process.env.KONG_ADMIN_URL || 'http://127.0.0.1:8001',
	+ kong_admin_url: process.env.KONG_ADMIN_URL || 'http://192.168.33.77:8001',
~$ cd ~/konga
~$ npm start

ブラウザでhttp://192.168.33.77:1338に接続する

Users登録    画面指示に従いユーザを登録する
Connections登録    Nameに任意の名前を入力する    Kong Admin URLにKong Admin API(http://localhost:8001)を入力する    CREATE CONNECTIONをクリックする
Services登録
	~$ curl -i -X POST \
	--url http://localhost:8001/services/ \
	--data 'name=service-yahoo-news-rss' \
	--data 'url=https://news.yahoo.co.jp/pickup/rss.xml'
Routes登録
	~$ curl -i -X POST \
	--url http://localhost:8001/services/service-yahoo-news-rss/routes \
	--data 'hosts[]=route-yahoo-news-rss'

