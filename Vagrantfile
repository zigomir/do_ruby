require 'yaml'

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'
Vagrant.require_plugin 'vagrant-digitalocean'

CONF = YAML.load_file('server_config.yml')

Vagrant.configure('2') do |config|
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled    = true
  provider_name = 'virtualbox'

  config.vm.provider :virtualbox do |provider, override|
    override.vm.box     = 'precise64'
    override.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    override.ssh.forward_agent = true

    override.vm.synced_folder CONF['virtualbox']['shared_dir']['host'], CONF['virtualbox']['shared_dir']['guest'],
      :nfs => (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)

    CONF['virtualbox']['forward_ports'].each do |port|
      override.vm.network :forwarded_port, guest: port, host: port
    end
    override.vm.network :private_network, ip: CONF['virtualbox']['private_ip']

    provider.customize ['modifyvm', :id, '--name',   CONF['virtualbox']['name']]
    provider.customize ['modifyvm', :id, '--memory', CONF['virtualbox']['memory']]
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box               = 'digital_ocean'
    override.vm.box_url           = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

    provider.client_id = CONF['digital_ocean']['client_id']
    provider.api_key   = CONF['digital_ocean']['api_key']
    provider.image     = CONF['digital_ocean']['image']
    provider.region    = CONF['digital_ocean']['region']
    provider.size      = CONF['digital_ocean']['size']

    provider_name = 'digital_ocean'
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt'
    chef.add_recipe 'git'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'rbenv::default'
    chef.add_recipe 'rbenv::ruby_build'
    chef.add_recipe 'user'

    chef.add_recipe 'do_ruby::default'
    chef.add_recipe 'do_ruby::user'
    chef.add_recipe 'do_ruby::ruby'
    chef.add_recipe 'do_ruby::postgres'
    chef.add_recipe 'do_ruby::passenger'
    chef.add_recipe 'do_ruby::node'

    # choose conf based on provider name (virtualbox or digital_ocean)
    chef.json = { chef_conf: CONF[provider_name] }
  end
end
