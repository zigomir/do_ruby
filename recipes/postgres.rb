# sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
execute "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list" do
  not_if { ::File.exists?('/etc/apt/sources.list.d/pgdg.list')}
end

# wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
# apt-get update
execute 'wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -' do
  notifies :run, 'execute[apt-get update]', :immediately
  not_if 'apt-key list | grep ACCC4CF8' # 0 if found, 1 if not
end

# apt-get install postgresql-common -t precise
# apt-get install postgresql-9.3 libpq-dev
['postgresql-common', 'postgresql-9.3', 'libpq-dev'].each do |pkg|
  package pkg
end

database_user = node[:do_ruby][:database][:user]

execute "echo \"CREATE USER #{database_user} WITH PASSWORD '#{database_user}';\" | psql" do
  user 'postgres'
  not_if "echo \"SELECT usename FROM pg_user;\" | psql | grep #{database_user}"
end

database_names = node[:do_ruby][:database][:names]
database_names.each do |database_name|
  execute "echo \"CREATE DATABASE #{database_name} WITH OWNER = #{database_user} TEMPLATE = template0 ENCODING = 'UTF-8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';\" | psql" do
    user 'postgres'
    not_if "echo \"SELECT datname FROM pg_database;\" | psql | grep #{database_name}"
  end

  execute "echo \"GRANT ALL PRIVILEGES ON DATABASE #{database_name} TO #{database_user};\" | psql" do
    user 'postgres'
  end
end
