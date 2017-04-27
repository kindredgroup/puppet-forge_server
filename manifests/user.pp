# == Class: forge_server::user
#
# Manages the forge user
#
class forge_server::user {
  user { $::forge_server::user:
    ensure => present,
    gid    => $::forge_server::user
  }

  # have to create a home dir or else systemd unit file will not start
  file { $::forge_server::user_homedir:
    ensure => directory,
    owner  => $::forge_server::user,
    group  => $::forge_server::user,
  }

  group { $::forge_server::user:
    ensure => present
  }
}
