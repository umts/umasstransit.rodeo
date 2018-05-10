name 'umasstransit_rodeo'
maintainer 'UMass Transit Service'
maintainer_email 'transit-it@admin.umass.edu'
license 'MIT'
description 'Installs/Configures umasstransit_rodeo'
long_description 'Installs/Configures umasstransit_rodeo'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

issues_url 'https://github.com/umts/umasstransit.rodeo/issues'
source_url 'https://github.com/umts/umasstransit.rodeo'

depends 'application', '~> 5.2.0'
