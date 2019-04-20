# HOW-TO set proxy for yum wget curl python and pip

## yum

   /etc/yum.conf�ɒǋL�B
   proxy=http://proxy.example.com:8080
   proxy_username=USERNAME
   proxy_password=PASSWORD


## wget

   /etc/wgetrc�ɒǋL�B
   http_proxy = http://USERNAME:PASSWD@proxy.example.com:8080/


## curl
   curl --proxy http://USERNAME:PASSWD@proxy.example.com:8080 -O http://yahoo.co.jp/index.html


## python
   python get-pip.py --proxy="http://USERNAME:PASSWD@proxy.example.com:8080"

	export HTTP_PROXY="http://proxy_host:8080"
	export HTTPS_PROXY="http://proxy_host:8080"


## pip
   pip --proxy http://USERNAME:PASSWD@proxy.example.com:8080 install pep8

