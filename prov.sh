#!/bin/bash
###Provisioning script for Simple Rails App Dev
###Requirements:
###Vagrant, virtualbox, centos6 or centos7
###Bonus for provisioning via salt. To be added at later date, first provisioning via shell.

###Update OS
sudo yum -y update

##install prereqs
sudo yum install -y epel-release
sudo yum groupinstall -y 'development tools'
sudo yum install -y nodejs curl-devel nano sqlite-devel libyaml-devel nginx git

#setup dirs for rails App
sudo mkdir -p /opt/app

#clone the git repo to run latest version of App
git clone https://github.com/railstutorial/sample_app.git /opt/app