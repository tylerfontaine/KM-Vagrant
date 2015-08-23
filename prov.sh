#!/bin/bash
###Provisioning script for Simple Rails App Dev
###Requirements:
###Vagrant, virtualbox, centos6 or centos7
###Bonus for provisioning via salt. To be added at later date, first provisioning via shell.

###Update OS
sudo yum -y update

##install os prereqs
sudo yum install -y epel-release
sudo yum groupinstall -y 'development tools'
sudo yum install -y nodejs curl-devel nano sqlite-devel libyaml-devel nginx git libxml2-devel libxslt-devel

##Install rvm for ruby, gem versioning
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.profile

#install the correct ruby version and set it to default
rvm install 1.9.3
rvm use 1.9.3 --default

#create wrapper for supervisord script
rvm alias create sample_app ruby-1.9.3-p551@sample_app

#set nginx conf
sudo cp /opt/config/default.conf /etc/nginx/conf.d/default.conf


#setup dirs for rails App
sudo mkdir -p /opt/app
sudo mkdir -p /opt/app/log
sudo chown -R vagrant:vagrant /opt/app

#clone the git repo to run latest version of App
git clone https://github.com/railstutorial/sample_app.git /opt/app

#set unicorn conf
sudo cp /opt/config/unicorn.rb /opt/app/config/

#setup rails app
cd /opt/app && bundle install && rake db:merge && gem install unicorn

#start unicorn and ngnix
cd /opt/app && unicorn_rails -c config/unicorn.rb -D
sudo service nginx restart

#supervisord setup
#first, easy_install
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python

sudo easy_install supervisor

#put config into place
sudo cp /opt/config/supervisord.conf /etc/

#create log dir
sudo mkdir -p /var/log/supervisor

#put init script in place
sudo cp /opt/config/supervisord.init /etc/init.d/supervisord
sudo chmod +x /etc/init.d/supervisord

#start supervisord and make sure supervisord and nginx start at boot
sudo service supervisord restart
sudo chkconfig supervisord on
sudo chkconfig nginx on

#fix vboxadd after kernel updates so the shares will mount on vagrant reload
sudo /etc/init.d/vboxadd setup


