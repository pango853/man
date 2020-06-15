


# mod_qosの検証 on CentOS 7


https://src.fedoraproject.org/rpms/mod_qos
http://mod-qos.sourceforge.net/


## Installation
yum install epel-release && yum update

yum install httpd
yum install mod_qos

```
cat << "_EOF_" >> /etc/httpd/conf.modules.d/10-mod_qos.conf

QS_ErrorPage                  /error-docs/qs_error.html

# restricts max concurrent requests for any location which has no
# individual rule:
QS_LocRequestLimitDefault                              200

# limits access to *.gif files to 100 concurrent requests:
QS_LocRequestLimitMatch       "^.*\.gif$"              100

# limits concurrent requests to the locations /images and /app/a:
QS_LocRequestLimit            /images                  100
QS_LocRequestLimit            /app/a                   300
# limits download bandwidth to 5Mbit/sec:
QS_LocKBytesPerSecLimit       /app/a                   640

# two locations (/app/b and /app/c) representing a single application:
QS_LocRequestLimitMatch       "^(/app/b/|/app/c/).*$"  300


# allows the application to nominate VIP users by sending a
# "mod-qos-vip" HTTP response header:
QS_VipHeaderName              mod-qos-vip
QS_SessionKey                 na&5san-sB.F4_0a=%D200ahLK1

<Location /qos>
   SetHandler qos-viewer
</Location>
<Location /qos/console>
   SetHandler qos-console
</Location>
_EOF_
```

## Commands
- qscheck
  Monitor programm testing the TCP connectivity to servers.
- qsfilter2
  access/audit ログから QS_Permit* ディレクティブとルールパターンを作成するルールジェネレーター
- qsgeo
  Adds the country code for the client IP address within a log file.
- qsgrep
  Searches a file for a pattern and prints the data in a new format.
- qshead
  an utility reading from stdin and printing all lines to stdout until reaching the defined pattern.
- qslogger
  Shell command interface to the syslog(3) system log module.
- qspng
  Creates graphics (png images) from the output of qslog.
- qssign
  A log data integrity check tool. It reads log data from stdin (pipe) and writes the signed data to stdout adding a sequence number and signatur to ever log line.
        qssign.rb is a Logstash filter plugin which may be used to verify the signatures of log messages in real time.
- qstail
  Shows the end of a log file beginning at a defined pattern.

## Test

Test handling 100 requests, with a maximum of 10 requests running concurrently:
> ab -n 100 -c 10 http://127.0.0.1/

> dd if=/dev/zero of=bigfile.bin bs=1024 count=10240
> ab -n 100 -c 10 http://127.0.0.1/test/bigfile.bin

curl -i http://127.0.0.1/test/bigfile.bin &
curl -i http://127.0.0.1/test/bigfile.bin &
curl -i http://127.0.0.1/test/bigfile.bin &
curl -i http://127.0.0.1/test/bigfile.bin &
curl -i http://127.0.0.1/test/bigfile.bin &

> ab -n 100 -c 10 http://127.0.0.1/app/a/
> ab -n 100 -c 10 http://127.0.0.1/app/a/test2.html


```
$ ab -n 1000 -c 10 http://127.0.0.1/app/a/
This is ApacheBench, Version 2.3 <$Revision: 1430300 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests


Server Software:        Apache/2.4.6
Server Hostname:        127.0.0.1
Server Port:            80

Document Path:          /app/a/
Document Length:        46 bytes

Concurrency Level:      10
Time taken for tests:   0.382 seconds
Complete requests:      1000
Failed requests:        411
   (Connect: 0, Receive: 0, Length: 411, Exceptions: 0)
Write errors:           0
Non-2xx responses:      411
Total transferred:      328631 bytes
HTML transferred:       46822 bytes
Requests per second:    2614.80 [#/sec] (mean)
Time per request:       3.824 [ms] (mean)
Time per request:       0.382 [ms] (mean, across all concurrent requests)
Transfer rate:          839.17 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0       1
Processing:     1    4   0.9      3       6
Waiting:        0    3   0.9      3       6
Total:          1    4   0.9      4       6
WARNING: The median and mean for the processing time are not within a normal deviation
        These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)
  50%      4
  66%      4
  75%      4
  80%      5
  90%      5
  95%      5
  98%      6
  99%      6
 100%      6 (longest request)
```

```/var/log/http/error_log
[Mon Jun 08 16:13:38.553057 2020] [qos:error] [pid 53984] [client 127.0.0.1:57180] mod_qos(010): access denied, QS_LocRequestLimit* rule: /app/a(3), concurrent requests=5, c=127.0.0.1, id=Xt5jsuV0Mc2iaYkcKN1lXgAAAAE
[Mon Jun 08 16:13:38.554849 2020] [qos:error] [pid 53989] [client 127.0.0.1:57190] mod_qos(010): access denied, QS_LocRequestLimit* rule: /app/a(3), concurrent requests=4, c=127.0.0.1, id=Xt5jsoImPi8lZwCCEg2Q1QAAAAU
[Mon Jun 08 16:13:38.555087 2020] [qos:error] [pid 53986] [client 127.0.0.1:57192] mod_qos(010): access denied, QS_LocRequestLimit* rule: /app/a(3), concurrent requests=5, c=127.0.0.1, id=Xt5jsqgKaFbg52bhfa8zywAAAAM
[Mon Jun 08 16:13:38.555158 2020] [qos:error] [pid 53985] [client 127.0.0.1:57194] mod_qos(010): access denied, QS_LocRequestLimit* rule: /app/a(3), concurrent requests=6, c=127.0.0.1, id=Xt5jsvl7G337sxlsLb93uQAAAAI
```


Requests per second:
Requests per second:    2614.80 [#/sec] (mean)



# apache で帯域制限をかける(mod_bw モジュールを使ってみた)
```
LoadModule bw_module          /usr/lib64/httpd/modules/mod_bw.so
...

<Directory "/var/www/html/video">
  <IfModule mod_bw.c>
    BandWidthModule On
    ForceBandWidthModule On
    BandWidth all 10240
    MaxConnection all 20		<-- 接続数を制限する
  </IfModule>
</Directory>
...
```

# スクレイパーとボットを制限するために、IPごとの最大ページビューを制限するのに役立つツールはどれですか？
## Iptablesソリューション

iptables -A FORWARD -m state --state NEW -m recent --rcheck --seconds 600 --hitcount 5 --name ATACK --rsource -j REJECT --reject-with icmp-port-unreachable
iptables -A FORWARD -d 127.0.0.1/32 -o eth1 -p tcp -m tcp --dport 80 -m recent --set --name ATACK --rsource -j ACCEPT

