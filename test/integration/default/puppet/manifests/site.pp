package { ['scl-utils', 'scl-utils-build', 'centos-release-SCL']: } ->
package { ['ruby193', 'ruby193-ruby-devel']: } ->
class { '::forge_server':
  scl => 'ruby193'
}
