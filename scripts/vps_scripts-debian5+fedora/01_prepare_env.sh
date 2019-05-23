# Disable Apache in Debian
sudo /etc/init.d/apache2 stop
sudo /usr/sbin/update-rc.d -f apache2 remove
#sudo /sbin/chkconfig httpd off
#sudo /sbin/service httpd stop

# Install compiler packages
sudo aptitude install gcc autoconf automake
#yum install gcc gcc-c++ autoconf automake
