source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : '>=3.7.3'

group :rspec, :kitchen do
  gem 'librarian-puppet'
  gem 'puppet', puppetversion
  gem 'rspec_junit_formatter'
  gem 'puppet-blacksmith'
end

group :rspec do
  if RUBY_VERSION <= '1.9.3'
    gem 'public_suffix', '1.4.6'
    gem 'metadata-json-lint', '1.2.2'
    gem 'rspec_junit_formatter', '0.2.3'
  end
  gem 'puppetlabs_spec_helper', '>= 0.1.0'
  gem 'puppet-lint', '< 1.1.0'
  gem 'facter', '>= 1.7.0'
  gem 'rspec-puppet', :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts', :require => false
  gem 'puppet-syntax'
end

group :kitchen do
  gem 'test-kitchen'
  gem 'kitchen-docker'
  gem 'kitchen-puppet', :git => 'https://github.com/neillturner/kitchen-puppet.git'
  gem 'kitchen-vagrant'
  gem 'vagrant-wrapper'
end
