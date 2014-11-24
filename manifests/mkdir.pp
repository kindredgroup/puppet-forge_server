define forge_server::mkdir () {

  if !defined(Exec["forge_server_mkdir_p_${name}"]) {
    exec { "forge_server_mkdir_p_${name}":
      command => "mkdir -p ${name}",
      creates => $name,
      path    => ['/bin', '/usr/bin']
    }
  }

}
