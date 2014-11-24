class forge_server::package {

  package { $forge_server::package:
    ensure    => present,
    provider  => gem
  }

}
