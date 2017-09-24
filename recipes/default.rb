

# adam_hdfs "upload_all_jars" do
# end

link "#{node['hops']['base_dir']}/share/hadoop/yarn/lib/#{node['adam']['jar']}" do
  owner node['hops']['yarn']['user']
  group node['hops']['group']
  to "#{node['adam']['base_dir']}/repo/#{node['adam']['jar']}"
end



avro_url = "#{node['adam']['avro_url']}"
base_package_filename = File.basename(avro_url)
file = "#{Chef::Config.file_cache_path}/#{base_package_filename}"
filename = File.basename(file)

remote_file file do
  source avro_url
  owner "#{node['adam']['user']}"
  mode "0644"
  action :create_if_missing
end

# Extract Adam
bash 'extract-avro-version' do
        user "root"
        code <<-EOH
                cd #{Chef::Config.file_cache_path}
                rm -f #{node['hops']['base_dir']}/share/hadoop/tools/lib/avro-1.7.4.jar
                rm -f #{node['hops']['base_dir']}/share/hadoop/common/lib/avro-1.7.4.jar
                rm -f #{node['hops']['base_dir']}/share/hadoop/mapreduce/lib/avro-1.7.4.jar
                rm -f #{node['hops']['base_dir']}/share/hadoop/kms/tomcat/webapps/kms/WEB-INF/lib/avro-1.7.4.jar
                rm -f #{node['hops']['base_dir']}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/avro-1.7.4.jar

                cp #{file} #{node['hops']['base_dir']}/share/hadoop/tools/lib/#{filename}
                cp #{file} #{node['hops']['base_dir']}/share/hadoop/common/lib/#{filename}
                cp #{file} #{node['hops']['base_dir']}/share/hadoop/mapreduce/lib/#{filename}
                cp #{file} #{node['hops']['base_dir']}/share/hadoop/yarn/lib/#{filename}
                cp #{file} #{node['hops']['base_dir']}/share/hadoop/kms/tomcat/webapps/kms/WEB-INF/lib/#{filename}
                cp #{file} #{node['hops']['base_dir']}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/#{filename}

                chown -R #{node['adam']['user']}:#{node['adam']['group']} #{node['adam']['dir']}/adam*
                chmod 750 #{node['adam']['dir']}/adam*
                service datanode restart
                service nodemanager restart
        EOH
     not_if { ::File.exists?( "#{node['hops']['base_dir']}/share/hadoop/common/lib/#{file}" ) }
end


