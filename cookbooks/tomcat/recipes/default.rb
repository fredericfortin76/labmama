#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#package 'epel-release'
package 'java-1.7.0-openjdk'
#package 'wget'

#group 'tomcat'
#
#user 'tomcat' do
#  group 'tomcat'
#  system true
#  shell '/bin/bash'
#end

service 'firewalld' do
  action [ :disable, :stop ]
end


# sudo groupadd tomcat
group 'tomcat'

#useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
  comment 'tomcat user'
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
end

#wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
remote_file 'apache-tomcat-8.5.15.tar.gz' do
  source 'http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz'
end
# create directory /opt/tomcat
directory '/opt/tomcat' do
  action :create
  group 'tomcat'
end

execute 'tar -zxvf apache-tomcat-8.5.15.tar.gz -C /opt/tomcat --strip-components=1'

execute 'chgrp -R tomcat /opt/tomcat'

execute 'chmod -R g+r conf' do
  cwd '/opt/tomcat'
end
execute 'chmod g+x /opt/tomcat/conf'

execute 'chown -R tomcat logs/ temp/ webapps/ work/' do
  cwd '/opt/tomcat'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
    action [ :start, :enable ]
end

execute 'firewall-cmd --zone=public --permanent --add-port=8080/tcp'
execute 'firewall-cmd --reload'

#package 'httpd-devel apr apr-devel apr-util apr-util-devel gcc gcc-c++ make autoconf libtool' do
#end

directory '/opt/mod_jk' do
  action :create
end

remote_file 'tomcat-connectors-1.2.42-src.tar.gz' do
  source 'http://www.eu.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.42-src.tar.gz'
end

execute 'tar -xvzf tomcat-connectors-1.2.42-src.tar.gz -C /opt/mod_jk --strip-components=1 '

execute './configure --with-apxs=/usr/bin/apxs --enable-api-compatibility' do
  cwd '/opt/mod_jk/native'
end
execute 'make install'do
  cwd '/opt/mod_jk/native'
end
