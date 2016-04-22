#
# Cookbook Name:: magento
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#Cover the provisioning dependency for ruby-dev
package "ruby-dev" do
  action :install
end

include_recipe 'lamp'

execute "/usr/sbin/php5enmod mcrypt" do
  only_if { platform?('ubuntu') && node['platform_version'].to_f >= 12.04 && ::File.exist?('/usr/sbin/php5enmod') }
end

include_recipe 'magento::_database_mysql'