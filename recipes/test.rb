#
# Cookbook Name:: magento
# Recipe:: test
#
# Copyright (c) 2014 The
# Authors, All Rights Reserved.
include_recipe "magento::n98magerun";


# Start magento install
magento_app "magento" do
  action :create
  sample_data true
  default_config true
end

web_app "magento" do
  template "magento.conf.erb"
  docroot "/var/www/magento"
  server_name node['fqdn']
  server_aliases node['magento']['aliases']
end

cron_d "magento cron" do
  command "cd /var/www/magento; /usr/bin/php cron.php"
  user    node['apache']['user']
end
# End magento install
