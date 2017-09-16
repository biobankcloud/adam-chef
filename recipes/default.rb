

# adam_hdfs "upload_all_jars" do
# end

link "#{node.hops.base_dir}/share/hadoop/yarn/lib/#{node['adam']['jar']}" do
  owner node["hops"]["yarn"]["user"]
  group node["hops"]["group"]
  to "#{node.adam.base_dir}/repo/#{node['adam']['jar']}"
end



avro_url = "#{node.adam.avro_url}"
base_package_filename = File.basename(avro_url)
cached_package_filename = "#{Chef::Config.file_cache_path}/#{base_package_filename}"

remote_file cached_package_filename do
  source avro_url
  owner "#{node.adam.user}"
  mode "0644"
  action :create_if_missing
end

# Extract Adam
bash 'extract-avro-version' do
        user "root"
        code <<-EOH
                cd #{Chef::Config.file_cache_path}
                rm -f #{node.hops.base_dir}/share/hadoop/tools/lib/avro-1.7.4.jar
                rm -f #{node.hops.base_dir}/share/hadoop/common/lib/avro-1.7.4.jar
                rm -f #{node.hops.base_dir}/share/hadoop/mapreduce/lib/avro-1.7.4.jar
                rm -f #{node.hops.base_dir}/share/hadoop/kms/tomcat/webapps/kms/WEB-INF/lib/avro-1.7.4.jar
                rm -f #{node.hops.base_dir}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/avro-1.7.4.jar

                cp #{cache_packaged_filename} #{node.hops.base_dir}/share/hadoop/tools/lib
                cp #{cache_packaged_filename} #{node.hops.base_dir}/share/hadoop/common/lib
                cp #{cache_packaged_filename} #{node.hops.base_dir}/share/hadoop/mapreduce/lib
                mv #{cache_packaged_filename} #{node.hops.base_dir}/share/hadoop/kms/tomcat/webapps/kms/WEB-INF/lib
                mv #{cache_packaged_filename} #{node.hops.base_dir}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib

                chown -R #{node.adam.user}:#{node.adam.group} #{node.adam.dir}/adam*
                chmod 750 #{node.adam.dir}/adam*
                service datanode restart
                service nodemanager restart
                touch #{node.adam.home}/.adam_extracted_#{node.adam.version}
        EOH
     not_if { ::File.exists?( "#{node.adam.home}/.adam_extracted_#{node.adam.version}" ) }
end


