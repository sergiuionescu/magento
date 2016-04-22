#
# Cookbook Name:: magento
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

actions :create, :delete
default_action :create

attribute :app_name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => node['magento']['version']
attribute :version_name, :kind_of => String, :default => node['magento']['version_name']
attribute :db_host, :kind_of => String, :default => node['magento']['db']['host']
attribute :db_name, :kind_of => String, :default => node['magento']['db']['name']
attribute :db_user, :kind_of => String, :default => node['magento']['db']['user']
attribute :db_pass, :kind_of => String, :default => node['magento']['db']['pass']
attribute :sample_data, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :default_config, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :base_url, :kind_of => String, :default => node['magento']['aliases'][0]
attribute :magerun_path, :kind_of => String, :default => node['magento']['n98magerun']['path']
attribute :web_user, :kind_of => String, :default => node['apache']['user']
attribute :web_group, :kind_of => String, :default => node['apache']['group']

attr_accessor :app_root
attr_accessor :exists