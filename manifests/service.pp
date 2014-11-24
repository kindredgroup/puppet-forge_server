class forge_server::service {

  service { 'puppet-forge-server':
    ensure => $::forge_server::service_ensure,
    enable => $::forge_server::service_enable
  }

}
