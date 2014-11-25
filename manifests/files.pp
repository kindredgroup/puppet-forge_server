# == Class: forge_server::files
#
# Directories needed by puppet-forge-server
#
class forge_server::files {

  $pid_dir = dirname($::forge_server::pidfile)

  ::forge_server::mkdir { $::forge_server::module_directory: }
  ::forge_server::mkdir { $::forge_server::log_dir: }
  ::forge_server::mkdir { $::forge_server::cache_basedir: }
  ::forge_server::mkdir { $pid_dir: }

  file { $pid_dir:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0755',
    require => ::Forge_server::Mkdir[$pid_dir]
  }

  file { $::forge_server::log_dir:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0700',
    require => ::Forge_server::Mkdir[$::forge_server::log_dir]
  }

  file { $::forge_server::module_directory:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0755',
    require => ::Forge_server::Mkdir[$::forge_server::module_directory]
  }

  file { $::forge_server::cache_basedir:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0755',
    require => ::Forge_server::Mkdir[$::forge_server::cache_basedir]
  }

}
