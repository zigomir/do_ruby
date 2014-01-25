name             'do_ruby'
maintainer       'Ziga Vidic'
maintainer_email 'zigomir@gmail.com'
license          'MIT'
description      'Digital Ocean box for Ruby/Rails projects'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'user', '~> 0.3.0'
depends 'apt', '~> 2.3.4'
depends 'git', '~> 2.9.0'
depends 'build-essential', '~> 1.4.2'
depends 'rbenv', '~> 1.7.1'
