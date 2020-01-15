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

#services
package 'npm'
package 'nginx'

nodejs_npm 'pm2'

service 'nginx' do
  action :start
end

service 'nginx' do
  action :enable
end
