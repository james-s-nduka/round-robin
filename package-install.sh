#!/bin/bash
curl https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz -o /tmp/go1.7.1.linux-amd64.tar.gz
tar -C /usr/local -xzf /tmp/go1.7.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bash_profile
sudo yum install wget -y
wget https://packages.chef.io/stable/el/7/chef-12.15.19-1.el7.x86_64.rpm -O /tmp/chef-12.15.19-1.el7.x86_64.rpm
sudo rpm -ivh /tmp/chef-12.15.19-1.el7.x86_64.rpm
sudo rm -rf /tmp/chef-12.15.19-1.el7.x86_64.rpm /tmp/go1.7.1.linux-amd64.tar.gz
# Necessary package for netstat
sudo yum install net-tools -y
# Necessary Packages for Ansible
sudo yum install epel-release -y
sudo yum install ansible -y