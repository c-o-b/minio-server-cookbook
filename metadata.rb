name		 'minio-server'
maintainer	 'Takaaki Furukawa'
maintainer_email 'takaaki.frkw@gmail.com'
license		 'MIT'
description	 'Installs/Configures Minio'
long_description 'Installs/Configures Minio'
chef_version	 '>= 12.14' if respond_to?(:chef_version)

version		 '0.2.0'

supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

issues_url 'https://github.com/tkak/minio-server-cookbook/issues'
source_url 'https://github.com/tkak/minio-server-cookbook'
