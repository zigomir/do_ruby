rbenv_ruby node[:do_ruby][:ruby][:version] do
  ruby_version node[:do_ruby][:ruby][:version]
  global true
end

rbenv_gem 'bundler'
