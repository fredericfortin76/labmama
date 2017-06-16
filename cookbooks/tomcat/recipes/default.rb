#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#package 'httpd'
#
#service 'httpd' do
#  action [:enable, :start]
#end
#
#service 'firewalld' do
#  action [ :disable, :stop ]
#end
#
#template '/var/www/html/index.html' do # ~FC033
#  source 'index.html.erb'
#end

package 'epel-release'
package 'java-1.7.0-openjdk'

group 'tomcat'

user 'tomcat' do
  group 'tomcat'
  system true
  shell '/bin/bash'
end


service 'firewalld' do
  action [ :disable, :stop ]
end
