#
# Cookbook Name:: magento
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource }") do
      create_db
      create_app
    end
  end
end

action :delete do
  if @current_resource.exists
    converge_by("Delete #{ @new_resource }") do
      delete_app
    end
  else
    Chef::Log.info "#{ @current_resource } not found - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::MagentoApp.new(@new_resource)

  @current_resource.name(@new_resource.name)
  @current_resource.app_name(@new_resource.app_name)
  @current_resource.app_root = "/var/www/#{@new_resource.name}"
  @current_resource.version(@new_resource.version)
  @current_resource.version_name(@new_resource.version_name)
  @current_resource.db_name(@new_resource.db_name)
  @current_resource.db_host(@new_resource.db_host)
  @current_resource.db_user(@new_resource.db_user)
  @current_resource.db_pass(@new_resource.db_pass)
  @current_resource.sample_data(@new_resource.sample_data)
  @current_resource.default_config(@new_resource.default_config)
  @current_resource.base_url(@new_resource.base_url)
  @current_resource.magerun_path(@new_resource.magerun_path)
  @current_resource.web_user(@new_resource.web_user)
  @current_resource.web_group(@new_resource.web_group)

  if application_installed?(@current_resource.app_root)
    @current_resource.exists = true
  end
end

def application_installed?(path)
  Dir.exist?(path)
end

def create_app
  cli="php -f #{current_resource.magerun_path}bin/n98-magerun"
  execute "#{current_resource.app_name} n98magerun-install" do
    cwd  '/var/www/'
    command "#{cli} install \
    --dbHost=#{current_resource.db_host} \
    --dbUser=#{current_resource.db_user} \
    --dbPass=#{current_resource.db_pass} \
    --dbName=#{current_resource.db_name} \
    --installSampleData=#{current_resource.sample_data == true ? 'yes' : 'no'} \
    --useDefaultConfigParams=#{current_resource.default_config == true ? 'yes' : 'no'} \
    --magentoVersionByName=#{current_resource.version_name} \
    --installationFolder=#{current_resource.app_root} \
    --baseUrl=#{current_resource.base_url} "
    not_if "#{cli} sys:info|grep #{current_resource.version}"
  end
  execute "#{current_resource.app_name} permission" do
    command "chown #{current_resource.web_user}:#{current_resource.web_group} -R #{current_resource.app_root}"
  end
end

def delete_app
  execute "magento-delete-#{current_resource.app_name}" do
    command "rm -rf #{current_resource.app_root}"
  end
end

def create_db
  mysql_connection_info = {:host => current_resource.db_host,
                           :username => 'root',
                           :password => node['lamp']['mysql']['root_password']}

  mysql_database current_resource.db_name do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user current_resource.db_user do
    connection mysql_connection_info
    password current_resource.db_pass
    database_name current_resource.db_name
    privileges [:all]
    action :grant
  end
end