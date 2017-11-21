# == Class: forge_server::user
#
# Manages the forge user
#
class forge_server::user {
  if $::forge_server::manage_user {
    user { $::forge_server::user:
      ensure => present,
      uid    => $::forge_server::userid,
      gid    => $::forge_server::user
    }

    # have to create a home dir or else systemd unit file will not start
    file { $::forge_server::user_homedir:
      ensure => directory,
      owner  => $::forge_server::user,
      group  => $::forge_server::user,
    }

    group { $::forge_server::user:
      gid    => $::forge_server::groupid,
      ensure => present
    }
  }
}
