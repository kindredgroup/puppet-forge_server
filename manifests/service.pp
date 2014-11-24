class forge_server::service {

  service { 'forge-server':
    ensure  => $::forge_server::service_ensure,
    enable  => $::forge_server::service_enable
  }

}
