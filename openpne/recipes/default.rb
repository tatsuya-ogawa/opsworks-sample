#
# Cookbook Name:: openpne
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

openpnedir=node[:deploy][:openpne][:deploy_to]+'/current'

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
EOS
end
