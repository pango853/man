# Install ImageMagick and dependencies
#sudo yum -y install glib glib2 libpng libjpeg libtiff ghostscript freetype ImageMagick 
ImageMagick-perl
sudo aptitude install imagemagick

# Install SQLite3 lib for Ruby
#sudo aptitude install libsqlite3-ruby
sudo aptitude install sqlite3 libsqlite3-ruby libsqlite-dev libsqlite3-dev
sudo gem install sqlite3-ruby

# Install MySQL server and client
#sudo yum -y install mysql-server mysql mysql-devel
sudo aptitude install mysql-server mysql-client
sudo aptitude install libmysql-ruby libmysqlclient-dev
sudo gem install mysql

# Install Phusion Passenger with Nginx
echo '= Please use the following settings when running Phusion Passenger 
installer'
echo '~ Please specify the directory: /home/ccube/source/nginx-0.7.64'
echo '~ Please specify a prefix directory [/opt/nginx]: 
/usr/local/nginx'
echo "~ Extra arguments to pass to configure script: 
--sbin-path='/usr/local/sbin' --with-http_ssl_module"

mkdir ~/source
cd ~/source
wget http://sysoev.ru/nginx/nginx-0.7.64.tar.gz
tar -zxvf nginx-0.7.64.tar.gz
sudo aptitude install build-essential zlib1g-dev
sudo gem install passenger
passenger-install-nginx-module
