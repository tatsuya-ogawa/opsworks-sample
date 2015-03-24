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
mail_domain = node[:deploy][:openpne][:mail_domain] || node[:domain]
basee_url = node[:deploy][:openpne][:base_url] || "https://#{node[:fqdn]}"

%w[OpenPNE.yml ProjectConfiguration.class.php].each do |file|
	#	execute 'move config' do
	#		command <<-EOS
	#if [ -f #{openpnedir}/config/#{file}.sample ] ; then
	#mv #{openpnedir}/config/#{file}.sample #{openpnedir}/config/#{file}
	#fi
	#EOS
	#	end
	template "#{openpnedir}/config/#{file}" do
		source "#{file}.erb"	
		mode '0644'
	end
end


execute 'openpne setup' do
	command <<-EOS
#{openpnedir}/symfony openpne:fast-install --dbms=mysql --dbuser=#{dbuser} --dbpassword=#{dbpass} --dbhost=#{dbhost} --dbname=#{dbname}
EOS
end
