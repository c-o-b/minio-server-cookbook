
default['minio']['install_method'] = 'binary'
case node['minio']['install_method']
when 'binary'
  default['minio']['url'] = 'https://dl.minio.io/server/minio/release/linux-amd64/minio'
  default['minio']['binary_path'] = '/usr/local/bin/minio'
  default['minio']['mode'] = '0755'
default['minio']['volume_path'] = '/data'
default['minio']['volumes'] = ['/data']
  default['minio']['envfile'] = '/etc/default/minio'
  default['minio']['systemdfile'] = '/etc/systemd/system/minio.service'
else
  default['minio']['yumrepo'] = 'https://copr-be.cloud.fedoraproject.org/results/lkiesow/minio/epel-$releasever-$basearch'
  default['minio']['binary_path'] = '/usr/bin/minio'
  default['minio']['volume_path'] = '/var/lib/minio'	# to match package; should be /srv/minio
  default['minio']['volumes'] = ['/var/lib/minio']
  default['minio']['envfile'] = '/etc/minio/minio.conf' # to suit the package; should be /etc/sysconfig/minio
  default['minio']['systemdfile'] = '/usr/lib/systemd/system/minio.service' # to suit the package
end

default['minio']['opts'] = '--address :9000'
default['minio']['access_key'] = nil
default['minio']['secret_key'] = nil
default['minio']['domain'] = nil
default['minio']['browser'] = nil
