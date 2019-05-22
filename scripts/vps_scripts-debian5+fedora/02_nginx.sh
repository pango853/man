# Install dependencies for Nginx
sudo aptitude -y install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
#sudo yum -y install pcre pcre-devel zlib zlib-devel openssl openssl-devel

# Compile Nginx
# This will be compiled when installing Phusion Passenger for Nginx
mkdir ~/source
cd ~/source
wget http://sysoev.ru/nginx/nginx-0.7.64.tar.gz
tar -zxvf nginx-0.7.64.tar.gz
cd nginx-0.7.64
./configure --sbin-path=/usr/local/sbin --with-http_ssl_module
make
sudo make install

# Make Nginx as service
sudo cp 02_nginx/etc_init-d_nginx /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
#sudo /sbin/chkconfig --add nginx
#sudo /sbin/chkconfig --level 3 nginx on

