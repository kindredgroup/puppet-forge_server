# == Class: forge_server
#
# Full description of class forge_server here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'forge_server':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class forge_server (
  $package          = $::forge_server::params::package,
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
  $debug            = false
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
