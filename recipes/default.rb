

# adam_hdfs "upload_all_jars" do
# end

link "#{node.hops.base_dir}/share/hadoop/yarn/lib/#{node['adam']['jar']}" do
  owner node["hops"]["yarn"]["user"]
  group node["hops"]["group"]
  to "#{node.adam.base_dir}/repo/#{node['adam']['jar']}"
end


