class forge_server::files {

  file { $::forge_server::log_dir:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0700'
  }

  file { $::forge_server::module_directory:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0755'
  }

  file { $::forge_server::cache_basedir:
    ensure  => directory,
    owner   => $::forge_server::user,
    group   => $::forge_server::user,
    mode    => '0755'
  }

}
