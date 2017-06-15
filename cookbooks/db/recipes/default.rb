#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

'recipe[selinux::disabled]'


# install wget pour aller chercher fichier remote
yum_package 'wget'


#Va chercher le package pour ajouter le repo de mysql dans yum
remote_file '/tmp/mysql57-community-release-el7-11.noarch.rpm' do
  source 'https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#inatallation du repo mysql
Dir['/tmp/*.rpm'].each do |path|
  rpm_package File.basename(path) do
    source path
  end
end


#install mysql
mysql_service 'foo' do
  port '3306'
  version '5.7'
  initial_root_password 'Qwerty69'
  action [:create, :start]
end