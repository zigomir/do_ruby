rbenv_ruby node[:do_ruby][:ruby][:version] do
  ruby_version node[:do_ruby][:ruby][:version]
  global       node[:do_ruby][:ruby][:global]
end

rbenv_gem 'bundler'
