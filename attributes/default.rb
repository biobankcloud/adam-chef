include_attribute "kagent"
include_attribute "spark"

default[:adam][:version]             = "0.18.2"
default[:adam][:user]                = "#{node[:spark][:user]}"
default[:adam][:group]               = "#{node[:spark][:group]}"
default[:adam][:base_dir]            = "/srv"
default[:adam][:home]                = "#{node[:adam][:base_dir]}/adam-distribution_#{node[:scala][:version]}-#{node[:adam][:version]}"
default[:adam][:url]                 = "#{default[:download_url]}/adam-distribution-#{default[:adam][:version]}-bin.tar.gz"
