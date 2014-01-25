user_name = node[:do_ruby][:user][:name]
ssh_keys  = node[:do_ruby][:user][:ssh_keys]

user_account user_name do
  comment    'User for deploying/running application'
  home       "/home/#{user_name}"
  ssh_keygen 'true'
  ssh_keys   ssh_keys
end
