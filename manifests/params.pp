# == Class: forge_server::params
#
# Default settings
#
class forge_server::params {
  $package = 'puppet-forge-server'
  $user = 'forge'
  $user_homedir = '/home/forge'
  $pidfile = '/var/run/puppet-forge-server/forge-server.pid'
  $port = 8080
  $bind_host = '127.0.0.1'
  $module_directory = '/var/lib/puppet-forge-server/modules'
  $proxy = undef
  $cache_basedir = '/var/lib/puppet-forge-server/cache'
  $log_dir = '/var/log/puppet-forge-server'
  $provider = 'gem'
  $http_proxy    = undef
  $scl_install_timeout = 300
  $scl_install_retries = 1
}
