group node.adam.group do
  action :create
  not_if "getent group #{node.adam.group}"
end

user node.adam.user do
  action :create
  gid node.adam.group
  system true
  shell "/bin/bash"
  not_if "getent passwd #{node.adam['user']}"
end

group node.adam.group do
  action :modify
  members ["#{node.adam.user}"]
  append true
  not_if {"#{node.adam.group}" == "#{node.adam.user}"}
end

package_url = "#{node.adam.url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config.file_cache_path}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node.adam.user}"
  mode "0644"
  action :create_if_missing
end

# Extract Adam
bash 'extract-adam' do
        user "root"
        code <<-EOH
                tar -xf #{cached_package_filename} -C #{node.adam.dir}
                chown -R #{node.adam.user}:#{node.adam.group} #{node.adam.dir}/adam*
                chmod 750 #{node.adam.dir}/adam*
                touch #{node.adam.home}/.adam_extracted_#{node.adam.version}
        EOH
     not_if { ::File.exists?( "#{node.adam.home}/.adam_extracted_#{node.adam.version}" ) }
end


link "#{node.adam.base_dir}" do
  owner node.adam.user
  group node.adam.group
  to node.adam.home
end



#master_ip = private_recipe_ip("hadoop_spark","master")
#namenode_ip = private_recipe_ip("hops","nn")
