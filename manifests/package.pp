# == Class: forge_server::package
#
# Installs puppet-forge-server
#
class forge_server::package {
  package {'ruby-devel':
    ensure => present,
  }

  package {'gcc':
    ensure => present,
  }

  if $::forge_server::scl {
    exec { 'scl_install_forge_server':
      command => "scl enable ${::forge_server::scl} 'gem install --bindir /usr/bin --no-rdoc --no-ri ${::forge_server::package}'",
      path    => ['/bin','/usr/bin'],
      unless  => "scl enable ${::forge_server::scl} 'gem list'| grep -qs ${::forge_server::package}",
      timeout => $::forge_server::scl_install_timeout,
      tries   => $::forge_server::scl_install_retries
    }
  } else {
    package { $forge_server::package:
      ensure   => present,
      provider => $::forge_server::provider
    }
  }

}
