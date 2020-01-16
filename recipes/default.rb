#
# Cookbook:: node_sample
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#imports
include_recipe 'apt'
include_recipe 'nodejs'


#npm install


#packges apt-get
apt_update

# resource services
package 'npm'
package 'nginx'

nodejs_npm 'pm2'

service 'nginx' do
  action :start
end

service 'nginx' do
  action :enable
end

# resource template
template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  notifies :restart, 'service[nginx]'
end

# resource link
link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default'do
  action :delete
  notifies :restart, 'service[nginx]'
end
