#
# Cookbook Name:: openpne
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "openpne::setup"  

openpnedir = node[:deploy][:openpne][:deploy_to]+'/current'
dbname = node[:deploy][:openpne][:database][:database]
dbuser = node[:deploy][:openpne][:database][:username]
dbpass = node[:deploy][:openpne][:database][:password]
dbhost = node[:deploy][:openpne][:database][:host]
dbname = node[:deploy][:openpne][:database][:database]
mail_domain = node[:deploy][:openpne][:mail_domain] || node[:domain]
base_url = node[:deploy][:openpne][:base_url] || "https://#{node[:fqdn]}"

execute 'openpne install' do
	command <<-EOS
#{openpnedir}/symfony openpne:fast-install --dbms=mysql --dbuser=#{dbuser} --dbpassword=#{dbpass} --dbhost=#{dbhost} --dbname=#{dbname}
EOS
end
