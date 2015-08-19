#
# Cookbook Name:: adam
# Recipe:: install
#
# Copyright 2015, Jim Dowling
#
# All rights reserved
#

# group node[:adam][:group] do
#   action :create
# end

user node[:adam][:user] do
  action :create
  system true
  shell "/bin/bash"
  not_if "getent passwd #{node[:adam]['user']}"
end

group node[:hadoop][:group] do
  action :modify
  members ["#{node[:adam][:user]}"]
  append true
end

package_url = "#{node[:adam][:url]}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node[:adam][:user]}"
  mode "0644"
  action :create_if_missing
end

# Extract Adam
bash 'extract-adam' do
        user node[:adam][:user]
        group node[:adam][:group]
        code <<-EOH
                tar -xf #{cached_package_filename} -C #{node[:adam][:base_dir]}
                touch #{node[:adam][:base_dir]}/.adam_extracted_#{node[:adam][:version]}
        EOH
     not_if { ::File.exists?( "#{node[:adam][:base_dir]}/.adam_extracted_#{node[:adam][:version]}" ) }
end


link "#{node[:adam][:base_dir]}/adam" do
  owner node[:adam][:user]
  group node[:adam][:group]
  to node[:adam][:home]
end


my_ip = my_private_ip()
master_ip = private_recipe_ip("spark","master")
namenode_ip = private_recipe_ip("hops","nn")
