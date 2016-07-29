#
# Cookbook Name:: round-robin
# Recipe:: appserver
#
# Copyright 2016, Synwin Solutions
#
# All rights reserved - Do Not Redistribute
#

directory '/src/round-robin' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/src/round-robin/app.go' do
  source 'app.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'compile and run app' do
  command '/usr/local/go/bin/go run /src/round-robin/app.go &'
  action :run
end
