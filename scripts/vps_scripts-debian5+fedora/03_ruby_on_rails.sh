# Install Ruby
#sudo yum -y install ruby ruby-devel ruby-irb ruby-rdoc ruby-ri
mkdir ~/source
cd ~/source
wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p248.tar.gz

tar xzvf ruby-1.8.7-p248.tar.gz
cd ruby-1.8.7-p248
sudo ./configure
sudo make
sudo make install

# Compile and install rubygems
mkdir ~/source
cd ~/source
wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz
tar xzvf rubygems-1.3.5.tgz
cd  rubygems-1.3.5
sudo ruby setup.rb
sudo gem update
sudo gem update --system

# Install latest rails
sudo gem install rails

# Install SQLite for Ruby
#sudo yum -y install sqlite-devel sqlite3-ruby
