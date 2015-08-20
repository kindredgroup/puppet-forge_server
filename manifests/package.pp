# == Class: forge_server::package
#
# Installs puppet-forge-server
#
class forge_server::package {

  if $::forge_server::scl {
    exec { 'scl_install_forge_server':
      command => "scl enable ${::forge_server::scl} 'gem install --bindir /usr/bin --no-rdoc --no-ri ${::forge_server::package}'",
      path    => ['/bin','/usr/bin'],
      unless  => "scl enable ${::forge_server::scl} 'gem list'| grep -qs ${::forge_server::package}"
    }
  } else {
    package { $forge_server::package:
      ensure   => $::forge_server::pkg_ensure,
      provider => $::forge_server::provider
    }
  }

  # If we are ensuring the latest gem package, uninstall old versions
  if $::forge_server::pkg_ensure == 'latest' {
    exec { "gem cleanup ${::forge_server::package}":
      path        => '/usr/bin',
      refreshonly => true,
      subscribe   => Package["$::forge_server::package"],
    }
  }

}
