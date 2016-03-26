name             'adam'
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2"
description      'Installs/Configures Adam/Spark'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"

depends          "spark"
depends          "kagent"
depends          "hadoop"
depends          "hops"

recipe           "install", "Installs Adam binaries"
recipe           "default", "Configures Adam"

attribute "adam/user",
:description => "Username to run adam as",
:type => 'string'

attribute "adam/group",
:description => "Groupname to run adam as",
:type => 'string'
