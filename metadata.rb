name             "adam"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2"
description      'Installs/Configures Adam/Spark'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

depends          "hadoop_spark"
depends          "kagent"
depends          "hops"

recipe           "install", "Installs Adam binaries"
recipe           "default", "Configures Adam"

attribute "adam/user",
:description => "Username to run adam as",
:type => 'string'

attribute "adam/group",
:description => "Groupname to run adam as",
:type => 'string'

attribute "adam/dir",
:description => "Base installation dir (default: /srv)",
:type => 'string'

attribute "install/dir",
          :description => "Set to a base directory under which we will install.",
          :type => "string"

attribute "install/user",
          :description => "User to install the services as",
          :type => "string"


