# == Define: forge_server::mkdir
#
# Helper define to create parent folders
#
define forge_server::mkdir () {

  if !defined(Exec["forge_server_mkdir_p_${name}"]) {
    exec { "forge_server_mkdir_p_${name}":
      command => "mkdir -p ${name}",
      unless  => "test -d ${name}",
      creates => $name,
      path    => ['/bin', '/usr/bin']
    }
  }

}
