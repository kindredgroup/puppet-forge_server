# == Class: forge_server::user
#
# Manages the forge user
#
class forge_server::user {
  user { $::forge_server::user:
    ensure => present,
    gid    => $::forge_server::user
  }
  group { $::forge_server::user:
    ensure => present
  }
}
