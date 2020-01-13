#
# Cookbook:: minio-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node['minio']['install_method']
when 'binary'
remote_file node['minio']['binary_path'] do
  source node['minio']['url']
  mode node['minio']['mode']
  action :create
end
else	# assume rhel7, expand massively for others
  if	# local or global kill-switch
      (x=node.read('minio','addrepo')).nil? ? 
    ( (y=node.read('yum','addrepos')).nil? ? true : y ) : x
    yum_repository 'minio' do
      baseurl	node.read('minio','yumrepo')||''
    end
  end

  package 'minio' do
    options (node.read('minio','yumoptions')|| node.read('yum','yumoptions')||'') if 
      (node.read('minio','yumoptions')|| node.read('yum','yumoptions'))
  end
end

directory node['minio']['volume_path'] do
  action :create
end

template node.read('minio','envfile')||'/etc/default/minio' do
  source 'minio.erb'
  mode '0644'
  variables(
    minio_volumes: node['minio']['volumes'],
    minio_opts: node['minio']['opts'],
    minio_access_key: node['minio']['access_key'],
    minio_secret_key: node['minio']['secret_key'],
    minio_domain: node['minio']['domain'],
    minio_browser: node['minio']['browser']
  )
  notifies :restart, 'service[minio]'
end

# The people who made systemd ignored the (fs)stnd location.  argh
template node.read('minio','systemdfile')||'/etc/systemd/system/minio.service' do
  action :create
  variables( minio: node['minio'] )
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'systemctl daemon-reload' do
  action :nothing
  user 'root'
end

service 'minio' do
#  provider Chef::Provider::Service::Systemd
  action [:start, :enable]
end
