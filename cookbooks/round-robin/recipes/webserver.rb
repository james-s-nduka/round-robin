#
# Cookbook Name:: round-robin
# Recipe:: webserver
#
# Copyright 2016, Synwin Solutions
#
# All rights reserved - Do Not Redistribute
#

package 'epel-release' do
  action :install
end

package 'nginx' do
  action :install
end

package 'net-tools' do
  action :install
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:start, :enable]
end

package 'policycoreutils-devel' do
  action :install
end
