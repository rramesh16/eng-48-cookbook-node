#
# Cookbook:: node_sample
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node_sample::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'enables nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'start the service' do
      expect(chef_run).to start_service 'nginx'
    end


    it 'should install nodejs from a recipe' do
      expect(chef_run).to include_recipe 'nodejs'
    end

    it 'should install apt from a recipe' do
      expect(chef_run).to include_recipe 'apt'
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm 'pm2'
    end

    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/proxy.conf').with_variables(proxy_port: node['nginx']]['proxy_port'])
    end

    it 'should create a symlink of proxy.conf from sites-available to sites-enabled' do
       expect(chef_run).to create_link('/etc/nginx/sites-enabled/proxy.conf').with_link_type(:symbolic)
     end

    it 'should delete the symlink from the default config in sites-enabled' do
      expect(chef_run).to delete_link '/etc/nginx/sites-enabled/default'
    end

    it 'runs_apt_update' do
      expect(chef_run).to update_apt_update 'updates_sources'
    end



#  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
#    platform 'centos', '7'

#    it 'converges successfully' do
  #    expect { chef_run }.to_not raise_error
  #  end
  end
end
