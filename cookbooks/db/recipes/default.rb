#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# Load MySQL passwords from the 'passwords' data bag.
# install wget pour aller chercher fichier remote
yum_package 'wget'
yum_package 'initscripts'

#Va chercher le package pour ajouter le repo de mysql dans yum
remote_file '/tmp/mysql57-community-release-el7-11.noarch.rpm' do
  source 'https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#inatallation du repo mysql
execute 'install_repo' do
  command 'rpm -ivh /tmp/mysql57-community-release-el7-11.noarch.rpm'
  not_if 'rpm -qa mysql57-community-release'
end

#install mysql
mysql_service 'foo' do
  port '3306'
  version '5.7'
  initial_root_password 'Qwerty69'
  action [:create, :start]
end


# Create a mysql database on a named mysql instance
#mysql_database 'oracle_rools' do
#  connection(
#    :host     => '127.0.0.1',
#    :username => 'root',
#    :socket   => "/var/run/mysql-foo/mysqld.sock",
#    :password => 'Qwerty69'
#  )
#  action :create
#end
