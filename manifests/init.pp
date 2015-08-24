# == Class: forge_server
#
# A Puppet module to manage the Puppet Forge Server service
#
# === Parameters
#
# [*package*]
#   Optional override of package name
#
# [*scl*]
#   Name of ruby scl environment, leave undef to use system ruby
#
# [*service_enable*]
#   Boolean if service should be enabled on boot
#
# [*service_ensure*]
#   Service ensure state
#
# [*service_refresh*]
#   Boolean if config changes and package changes should trigger service restart
#
# [*pidfile*]
#   Path to pidfile
#
# [*port*]
#   Port to bind to
#
# [*bind_host*]
#   IP or host to bind to
#
# [*daemonize*]
#   Boolean if should be daemonized
#
# [*module_directory*]
#   Directory of modules to serve, can be an array of directories
#
# [*proxy*]
#   Proxy requests to this upstream forge url
#
# [*cache_basedir*]
#   Path where to store proxied / cached modules
#
# [*log_dir*]
#   Path to log directory
#
# [*debug*]
#   Boolean to toggle debug
#
# [*provider*]
#   Provider for the gem package install; defaults to gem; 
#   can be set to pe_gem or puppet_gem depending on Puppet version
#
# [*pkg_ensure*]
#   String specifying specific version number; possible values include:
#     - 'latest': keep the gem package up to date (default)
#     - '<version number>': install this specific version number
#     - 'present': install the version available at the time of first run
#       and do not update afterwards
#
# === Examples
#
#  class { '::forge_server':
#    scl => 'ruby193'
#  }
#
# === Authors
#
# Johan Lyheden <johan.lyheden@unibet.com>
#
# === Copyright
#
# Copyright 2014 North Development AB
#
class forge_server (
  $package          = $::forge_server::params::package,
  $scl              = undef,
  $service_enable   = true,
  $service_ensure   = 'running',
  $service_refresh  = true,
  $pidfile          = $::forge_server::params::pidfile,
  $port             = $::forge_server::params::port,
  $bind_host        = $::forge_server::params::bind_host,
  $daemonize        = true,
  $module_directory = $::forge_server::params::module_directory,
  $proxy            = $::forge_server::params::proxy,
  $cache_basedir    = $::forge_server::params::cache_basedir,
  $log_dir          = $::forge_server::params::log_dir,
  $debug            = false,
  $provider         = 'gem',
  $pkg_ensure       = 'present',
) inherits forge_server::params {

  # contain class and ordering
  anchor { '::forge_server::begin': } ->
  class { '::forge_server::user': } ->
  class { '::forge_server::package': } ->
  class { '::forge_server::config': } ->
  class { '::forge_server::files': } ->
  class { '::forge_server::service': } ->
  anchor { '::forge_server::end': }

  # optional refresh
  if $service_refresh {
    Class['::forge_server::package'] ~> Class['::forge_server::service']
    Class['::forge_server::config'] ~> Class['::forge_server::service']
  }

}
