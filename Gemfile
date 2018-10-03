source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '>=3.7.3'

group :rspec, :kitchen do
  gem 'librarian-puppet'
  gem 'puppet', puppetversion
  gem 'rspec_junit_formatter'
  gem 'puppet-blacksmith'
end

group :rspec do
  gem 'puppetlabs_spec_helper', '~> 1.1'
  gem 'puppet-lint', '< 1.1.0'
  gem 'facter', '~> 2.5'
  gem 'rspec-puppet', :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts', :require => false
  gem 'puppet-syntax'
  gem 'metadata-json-lint', '~> 1.1.0'
end

group :kitchen do
  gem 'test-kitchen', '~> 1.16.0'
  gem 'kitchen-docker'
  gem 'kitchen-puppet', :git => 'https://github.com/neillturner/kitchen-puppet.git', :tag => '3.1.1'
  gem 'kitchen-vagrant'
  gem 'vagrant-wrapper'
end
