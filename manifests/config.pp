class forge_server::config {

  # Scope config variables for templates
  $user = $::forge_server::user
  $pidfile = $::forge_server::pidfile
  $port = $::forge_server::port
  $bind_host = $::forge_server::bind_host
  $daemonize = $::forge_server::daemonize
  $module_directory = $::forge_server::module_directory
  $proxy = $::forge_server::proxy
  $cache_basedir = $::forge_server::cache_basedir
  $log_dir = $::forge_server::log_dir
  $debug = $::forge_server::debug

  file { '/etc/default/forge-server':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/forge-server.default.erb")
  }

  file { '/etc/init/forge-server.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/forge-server.init.erb")
  }

}
