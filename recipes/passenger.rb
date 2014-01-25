# sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
# sudo gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -
execute 'gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 && gpg --armor --export 561F9B9CAC40B2F7 | apt-key add -' do
  not_if 'apt-key list | grep Phusion' # 0 if found, 1 if not
end

# echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main" >> /etc/apt/sources.list.d/passenger.list
# apt-get update
execute "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main' > /etc/apt/sources.list.d/passenger.list" do
  notifies :run, 'execute[apt-get update]', :immediately
  not_if { ::File.exists?('/etc/apt/sources.list.d/passenger.list')}
end

# apt-get install libapache2-mod-passenger passenger
['libapache2-mod-passenger', 'passenger'].each do |pkg|
  package pkg
end

template '/etc/apache2/sites-available/app.conf' do
  source 'app.conf.erb'
  mode 0640
  owner 'root'
  group 'root'
  variables({
    :server_name  => 'localhost',
    :ruby_version => node[:do_ruby][:ruby][:version]
  })
end

service 'apache2' do
  supports :restart => true, :reload => true
  action :enable
end

execute 'a2ensite app.conf' do
  cwd '/etc/apache2/sites-available/'
  notifies :reload, 'service[apache2]'
  not_if { ::File.exists?('/etc/apache2/sites-enabled/app.conf')}
end

execute 'a2dissite default' do
  cwd '/etc/apache2/sites-available/'
  notifies :reload, 'service[apache2]'
  only_if { ::File.exists?('/etc/apache2/sites-enabled/000-default')}
end
