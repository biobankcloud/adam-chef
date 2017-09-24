include_attribute "kagent"
include_attribute "hadoop_spark"

default['scala']['version']            = "2.11"
default['adam']['version']             = "0.23.0-SNAPSHOT"
default['adam']['user']                = node['install']['user'].empty? ? node['hadoop_spark']['user'] : node['install']['user'] 
default['adam']['group']               = node['install']['user'].empty? ? node['hadoop_spark']['group'] : node['install']['user'] 
default['adam']['dir']                 = node['install']['dir'].empty? ?  "/srv"  : node['install']['dir']
default['adam']['home']                = "#{node['adam']['dir']}/adam-distribution-spark2_#{node['scala']['version']}-#{node['adam']['version']}"
default['adam']['base_dir']            = "#{node['adam']['dir']}/adam"
# https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution_2.11/0.22.0/adam-distribution_2.11-0.22.0-bin.tar.gz
default['adam']['url']                 = "#{node['download_url']}/adam-distribution-spark2_#{node['scala']['version']}-#{default['adam']['version']}-bin.tar.gz"

# adam_2.11-0.22.0.jar
default['adam']['jar']                 = "adam-assembly-spark2_#{node['scala']['version']}-#{node['adam']['version']}.jar"

default['adam']['avro_url']            = "#{node['download_url']}/avro-1.7.7.jar"
