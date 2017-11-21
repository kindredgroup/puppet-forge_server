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
# [*scl_install_timeout*]
#   If using ruby scl, the timeout in seconds to allow the gem installation to run
#
# [*scl_install_retries*]
#   If using ruby scl, the number of retries allowed if gem installation fails
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
# [*http_proxy*]
#   Use proxyserver for http(s) connections
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
# [*manage_user*]
#   Boolean to toggle management of user and group resources
#
# [*userid*]
#   Fixed UID of the forge user
#
# [*groupid*]
#   Fixed GID of the forge group
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
  $package             = $::forge_server::params::package,
  $scl                 = undef,
  $scl_install_timeout = $::forge_server::params::scl_install_timeout,
  $scl_install_retries = $::forge_server::params::scl_install_retries,
  $service_enable      = true,
  $service_ensure      = 'running',
  $service_refresh     = true,
  $pidfile             = $::forge_server::params::pidfile,
  $port                = $::forge_server::params::port,
  $bind_host           = $::forge_server::params::bind_host,
  $daemonize           = true,
  $module_directory    = $::forge_server::params::module_directory,
  $http_proxy          = $::forge_server::params::http_proxy,
  $proxy               = $::forge_server::params::proxy,
  $cache_basedir       = $::forge_server::params::cache_basedir,
  $log_dir             = $::forge_server::params::log_dir,
  $debug               = false,
  $provider            = 'gem',
  $manage_user         = true,
  $userid              = undef,
  $groupid             = undef
) inherits forge_server::params {

  if $scl {
    if $::osfamily == 'RedHat' {
      validate_integer($scl_install_timeout)
      validate_integer($scl_install_retries)
    } else {
      fail("SCL is not a valid configuration option for ${::osfamily} systems")
    }
  }

  validate_absolute_path($module_directory)
  validate_absolute_path($cache_basedir)
  validate_absolute_path($log_dir)

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
