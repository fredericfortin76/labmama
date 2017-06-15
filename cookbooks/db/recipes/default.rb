#
# Cookbook:: db
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
yum_package 'wget'





mysql_service 'foo' do
  port '3306'
  version '5.7'
  initial_root_password 'Qwerty69'
  action [:create, :start]
end