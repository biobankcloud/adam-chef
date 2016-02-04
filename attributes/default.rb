include_attribute "kagent"
include_attribute "spark"

default[:scala][:version]            = "2.11"
default[:adam][:version]             = "0.18.2"
default[:adam][:user]                = "#{node[:spark][:user]}"
default[:adam][:group]               = "#{node[:spark][:group]}"
default[:adam][:base_dir]            = "/srv"

default[:adam][:home]                = "#{node[:adam][:base_dir]}/adam-distribution_#{node[:scala][:version]}-#{node[:adam][:version]}"
default[:adam][:url]                 = "#{default[:download_url]}/adam/adam-distribution_#{node.scala.version}-#{default[:adam][:version]}-bin.tar.gz"

default[:adam][:jar]                 = "adam-cli_#{node.scala.version}-#{node.adam.version}.jar
