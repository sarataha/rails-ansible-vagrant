sudo apt-get update
sudo apt-get install git -y
sudo apt-get install nodejs -y
sudo apt-get install libmysqlclient-dev -y

sudo gem install bundler
sudo gem install rails
sudo gem install actionpack -v '4.2.3'

cd /vagrant
bundle install
rake db:drop db:create db:migrate db:seed
rails server -b 192.168.66.66
