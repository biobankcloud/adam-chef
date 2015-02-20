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

recipe           "default", "Installs Adam"
