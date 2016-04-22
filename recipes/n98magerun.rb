#
# Cookbook Name:: magento
# Recipe:: n98magerun
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute "install-n98magerun" do
  command "composer -- create-project n98/magerun #{node['magento']['n98magerun']['path']}"
  not_if "ls #{node['magento']['n98magerun']['path']}bin/n98-magerun"
end