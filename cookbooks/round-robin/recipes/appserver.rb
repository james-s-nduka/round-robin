#
# Cookbook Name:: round-robin
# Recipe:: appserver
#
# Copyright 2016, Synwin Solutions
#
# All rights reserved - Do Not Redistribute
#

package 'net-tools' do
  action :install
end

execute 'compile and run app' do
  command '/usr/local/go/bin/go run /src/round-robin/app.go &'
  action :run
end
