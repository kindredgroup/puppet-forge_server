# == Class: forge_server::service
#
# Manages the puppet-forge-server daemon
#
class forge_server::service {

  if $::forge_server::service_enable == true {
    service { 'puppet-forge-server':
      ensure   => $::forge_server::service_ensure,
      enable   => $::forge_server::service_enable,
      provider => 'init',
    }
  }

}
