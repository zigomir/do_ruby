user_account 'deployer' do
  comment    'User for deploying application'
  home       '/home/deployer'
  ssh_keygen 'true'
  ssh_keys    node[:do_ruby][:ssh_keys]
end
