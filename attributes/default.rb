# User
default[:do_ruby][:user][:name]     = node[:chef_conf][:user][:name]
default[:do_ruby][:user][:ssh_keys] = node[:chef_conf][:user][:ssh_keys]

# Ruby
default[:do_ruby][:ruby][:version]  = node[:chef_conf][:ruby][:version]
default[:rbenv][:user]              = node[:chef_conf][:ruby][:user]
default[:rbenv][:group]             = node[:chef_conf][:ruby][:group]
default[:do_ruby][:ruby][:global]   = node[:chef_conf][:ruby][:global]

# Postgres
default[:do_ruby][:database][:names] = node[:chef_conf][:database][:names]
default[:do_ruby][:database][:user]  = node[:chef_conf][:database][:user]
