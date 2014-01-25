# Will automatically run apt-update
apt_repository 'chris-lea-node.js' do
  uri 'http://ppa.launchpad.net/chris-lea/node.js/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  key 'C7917B12'
  keyserver 'keyserver.ubuntu.com'
  action :add
end

# apt-get install nodejs
package 'nodejs'

# install bower globally
execute 'npm install -g bower' do
  not_if { ::File.exists?('/usr/bin/bower')}
end
