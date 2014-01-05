# Digital Ocean Ruby / Postgres / Node droplet with Chef

## Using this cookbook in for your project

Install [VirtualBox](https://www.virtualbox.org/) and then [Vagrant](http://www.vagrantup.com/).

```bash
gem install berkshelf --pre
vagrant plugin install vagrant-berkshelf --plugin-version 1.4.0.dev1
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-digitalocean
```

Create `Berksfile` in your project's root directory

```ruby
source 'http://api.berkshelf.com'

cookbook 'do_ruby', github: 'zigomir/do_ruby'
```

Copy `Vagrantfile` to your project's root directory

```bash
berks install
```

## Creating new Vagrant machine

```bash
vagrant up
```

## Creating new DigitalOcean droplet

Create `server_config.yml` file and fill it with values. Take a look in
[server_config.SAMPLE.yml](server_config.SAMPLE.yml).

We're using [Vagrant-DigitalOcean](https://github.com/smdahlen/vagrant-digitalocean)
plugin to set up a droplet on DigitalOcean.

If you've build your machine with VirtualBox provider before you'll probably need
to destroy it first, since Vagrant doesn't support multiple providers on same box
just yet. But they plan to. Command for destroying is `vagrant destroy`.

```bash
vagrant up --provider=digital_ocean
```

```bash
ssh deployer@ip
cat .ssh/id_dsa.pub # add to https://github.com/settings/ssh
ssh -T git@github.com
exit
```

### Possible problems

```
Shared folders that Chef requires are missing on the virtual machine.
This is usually due to configuration changing after already booting the
machine. The fix is to run a `vagrant reload` so that the proper shared
folders will be prepared and mounted on the VM.
```

TODO: find out how to work around it

## TODO

- define user and app name in `server_config.yml` or `attributes`?
- wget/curl command to get `Vagrantfile` and server_config.yml copied to
your project
