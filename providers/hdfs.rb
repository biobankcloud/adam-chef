action :upload_jars do

home = "#{node['hops']['hdfs']['user_home']}/#{node['adam']['user']}"
  
hops_hdfs_directory "#{home}" do
  action :create
  owner node['adam']['user']
  mode "1777"
  not_if ". #{node['hops']['home']}/sbin/set-env.sh && #{node['hops']['home']}/bin/hdfs dfs -test -d #{home}"
end

jar_path = "hdfs://#{home}/adam-cli.jar"

hops_hdfs_directory "#{node['adam']['home']}/repo/#{node['adam']['jar']}" do
  action :put_as_superuser
  owner node['adam']['user']
  group node['adam']['group']
  mode "1755"
  dest jar_path
  not_if ". #{node['hops']['home']}/sbin/set-env.sh && #{node['hops']['home']}/bin/hdfs dfs -test -f #{node['adam']['home']}/repo/#{node['adam']['jar']}"
end


link "#{node['hops']['base_dir']}/share/hadoop/yarn/lib/#{jarFile}" do
  owner node['hops']['yarn']['user']
  group node['hops']['group']
  to "#{node['adam']['base_dir']}/lib/#{jarFile}"
end

link "#{node['adam']['base_dir']}" do
  owner node['adam']['user']
  group node['adam']['group']
  to node['adam']['home']
end



# new_resource.updated_by_last_action(false)

#   bash "upload_hdfs_jars-#{new_resource.name}" do
#     user node['adam']['user']
#     code <<-EOF
#      set -e
#      . #{node['hops']['home']}/sbin/set-env.sh
# cd #{node['hops']['home']}/bin
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/commons-cli/commons-cli/1.2/commons-cli-1.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/commons-httpclient/commons-httpclient/3.1/commons-httpclient-3.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/commons-codec/commons-codec/1.4/commons-codec-1.4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/ta rget/appassembler/repo/org/apache/commons/commons-compress/1.4.1/commons-compress-1.4.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/tukaani/xz/1.0/xz-1.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/slf4j/slf4j-api/1.7.5/slf4j-api-1.7.5.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/log4j/log4j/1.2.17/log4j-1.2.17.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/xerial/snappy/snappy-java/1.1.1.6/snappy-java-1.1.1.6.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scoverage/scalac-scoverage-plugin_2.10/0.99.2/scalac-scoverage-plugin_2.10-0.99.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/commons-io/commons-io/1.3.2/commons-io-1.3.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/bdgenomics/bdg-formats/bdg-formats/0.4.0/bdg-formats-0.4.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/avro/avro/1.7.6/avro-1.7.6.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/codehaus/jackson/jackson-core-asl/1.9.13/jackson-core-asl-1.9.13.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/codehaus/jackson/jackson-mapper-asl/1.9.13/jackson-mapper-asl-1.9.13.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/thoughtworks/paranamer/paranamer/2.3/paranamer-2.3.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/bdgenomics/adam/adam-core/0.15.1-SNAPSHOT/adam-core-0.15.1-SNAPSHOT.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/esotericsoftware/kryo/kryo/2.21/kryo-2.21.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/esotericsoftware/reflectasm/reflectasm/1.07/reflectasm-1.07-shaded.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/ow2/asm/asm/4.0/asm-4.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/esotericsoftware/minlog/minlog/1.2/minlog-1.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/objenesis/objenesis/1.2/objenesis-1.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/it/unimi/dsi/fastutil/6.4.4/fastutil-6.4.4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-avro/1.6.0rc4/parquet-avro-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-column/1.6.0rc4/parquet-column-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-common/1.6.0rc4/parquet-common-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-encoding/1.6.0rc4/parquet-encoding-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-generator/1.6.0rc4/parquet-generator-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-hadoop/1.6.0rc4/parquet-hadoop-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-jackson/1.6.0rc4/parquet-jackson-1.6.0rc4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/twitter/parquet-format/2.2.0-rc1/parquet-format-2.2.0-rc1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/seqdoop/hadoop-bam/7.0.0/hadoop-bam-7.0.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/seqdoop/cofoja/1.1-r150/cofoja-1.1-r150.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/seqdoop/htsjdk/1.118/htsjdk-1.118.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/ant/ant/1.8.2/ant-1.8.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/ant/ant-launcher/1.8.2/ant-launcher-1.8.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/bcel/bcel/5.2/bcel-5.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/jakarta-regexp/jakarta-regexp/1.4/jakarta-regexp-1.4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/commons/commons-jexl/2.1.1/commons-jexl-2.1.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/testng/testng/6.8.8/testng-6.8.8.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/beanshell/bsh/2.0b4/bsh-2.0b4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/beust/jcommander/1.27/jcommander-1.27.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/httpcomponents/httpclient/4.3.2/httpclient-4.3.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/apache/httpcomponents/httpcore/4.3.1/httpcore-4.3.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/netflix/servo/servo-core/0.5.5/servo-core-0.5.5.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/google/code/findbugs/annotations/2.0.0/annotations-2.0.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/bdgenomics/adam/adam-apis/0.15.1-SNAPSHOT/adam-apis-0.15.1-SNAPSHOT.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scala-lang/scala-library/2.10.4/scala-library-2.10.4.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/slf4j/slf4j-log4j12/1.7.5/slf4j-log4j12-1.7.5.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/args4j/args4j/2.0.23/args4j-2.0.23.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/fusesource/scalate/scalate-core_2.10/1.6.1/scalate-core_2.10-1.6.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/fusesource/scalate/scalate-util_2.10/1.6.1/scalate-util_2.10-1.6.1.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scala-lang/scala-compiler/2.10.0/scala-compiler-2.10.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scalatra/scalatra-json_2.10/2.3.0/scalatra-json_2.10-2.3.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/json4s/json4s-core_2.10/3.2.10/json4s-core_2.10-3.2.10.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/json4s/json4s-ast_2.10/3.2.10/json4s-ast_2.10-3.2.10.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scala-lang/scalap/2.10.0/scalap-2.10.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scalatra/scalatra_2.10/2.3.0/scalatra_2.10-2.3.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scalatra/scalatra-common_2.10/2.3.0/scalatra-common_2.10-2.3.0.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/clapper/grizzled-slf4j_2.10/1.0.2/grizzled-slf4j_2.10-1.0.2.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scalatra/rl/rl_2.10/0.4.10/rl_2.10-0.4.10.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/com/googlecode/juniversalchardet/juniversalchardet/1.0.3/juniversalchardet-1.0.3.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/eu/medsea/mimeutil/mime-util/2.1.3/mime-util-2.1.3.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/joda-time/joda-time/2.3/joda-time-2.3.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/joda/joda-convert/1.6/joda-convert-1.6.jar /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli/target/appassembler/repo/org/scala-lang/scala-reflect/2.10.4/scala-reflect-2.10.4.ja /user/#{node['adam']['user']}/repo
# ./hdfs dfs -copyFromLocal #{node['adam']['home']}/adam-cli-0.15.1-SNAPSHOT.jar /user/#{node['adam']['user']}/repo 


# #     #{node['hops']['home']}/bin/hadoop fs -chmod #{new_resource.mode} #{new_resource.name} 
#     EOF
#   end

end
