default[:do_ruby][:ruby][:version]  = node[:chef_conf][:ruby_version]
default[:do_ruby][:database][:name] = node[:chef_conf][:database_name]
default[:do_ruby][:ssh_keys]        = node[:chef_conf][:ssh_keys]
