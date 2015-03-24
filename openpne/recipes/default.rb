#
# Cookbook Name:: openpne
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

openpnedir = node[:deploy][:openpne][:deploy_to]+'/current'
dbname = node[:deploy][:openpne][:database][:database]
dbuser = node[:deploy][:openpne][:database][:username]
dbpass = node[:deploy][:openpne][:database][:password]
dbhost = node[:deploy][:openpne][:database][:host]
dbname = node[:deploy][:openpne][:database][:database]
openpne_admin_email = node[:deploy][:openpne][:admin_email] 
openpne_url = node[:deploy][:openpne][:site_url] 

%w[OpenPNE.yml ProjectConfiguration.class.php].each do |file|
	execute 'move config' do
		command <<-EOS
if [ -f #{openpnedir}/config/#{file}.sample ] ; then
mv #{openpnedir}/config/#{file}.sample #{openpnedir}/config/#{file}
fi
EOS
	end
end

execute 'openpne setup' do
	command <<-EOS
#{openpnedir}/symfony openpne:fast-install --dbms=mysql --dbuser=#{dbuser} --dbpassword=#{dbpass} --dbhost=#{dbhost} --dbname=#{dbname}
EOS
end
