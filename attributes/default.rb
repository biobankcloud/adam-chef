include_attribute "kagent"
include_attribute "hadoop_spark"

default.scala.version            = "2.11"
default.adam.version             = "0.21.0"
default.adam.user                = "#{node.hadoop_spark.user}"
default.adam.group               = "#{node.hadoop_spark.group}"
default.adam.dir                 = node.install.dir.empty? ? node.install.dir :  "/srv" 
default.adam.home                = "#{node.adam.dir}/adam-distribution-spark2_#{node.scala.version}-#{node.adam.version}"
default.adam.base_dir            = "#{node.adam.dir}/adam"
# adam-distribution-spark2_2.11-0.20.0-bin.tar.gz
# adam-distribution-spark2_2.11-0.21.0-bin
default.adam.url                 = "#{default.download_url}/adam-distribution-spark2_#{node.scala.version}-#{default.adam.version}-bin.tar.gz"

default.adam.jar                 = "adam_#{node.scala.version}-#{node.adam.version}.jar"
