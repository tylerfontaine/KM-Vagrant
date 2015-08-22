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
sudo yum install -y nodejs curl-devel nano sqlite-devel libyaml-devel nginx git

##Install rvm for ruby, gem versioning
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rails,unicorn
source ~/.profile

#setup dirs for rails App
sudo mkdir -p /opt/app
sudo chown vagrant:vagrant /opt/app

#clone the git repo to run latest version of App
git clone https://github.com/railstutorial/sample_app.git /opt/app

#setup rails app
mv /opt/app/Gemfile.lock /opt/app/Gemfile.lock.old
cd /opt/app && bundle install
cd /opt/app && rails s >> /tmp/railsapp.log