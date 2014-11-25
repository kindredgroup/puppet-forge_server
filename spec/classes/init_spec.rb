require 'spec_helper'
describe 'forge_server' do

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
    it {
      should contain_package('puppet-forge-server')
    }
    it {
      should_not contain_exec('scl_install_forge_server')
    }
    it {
      should_not contain_file('/etc/init.d/puppet-forge-server').with_content(/export LD_LIBRARY_PATH=.*\nexport GEM_PATH=.*\nexport PATH=.*\n/)
    }
  end

  context 'with single module path and proxy' do
    let(:params) { {
      :module_directory => 'dir1',
      :proxy            => 'proxy1'
    } }

    it {
      should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \\"dir1\\""\n\n/)
    }
    it {
      should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\n\n/)
    }
  end

  context 'with multiple module paths and proxies' do
    let(:params) { {
      :module_directory => ['/dir1', '/dir2'],
      :proxy            => ['proxy1', 'proxy2']
    } }

    it {
      should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \\"\/dir1\\""\nPARAMS="\${PARAMS} --module-dir \\"\/dir2\\""\n/)
    }
    it {
      should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\nPARAMS="\${PARAMS} --proxy proxy2"\n/)
    }
  end

  context 'with service_refresh => false' do
    let(:params) { {
      :service_refresh  => false
    } }

    it {
      should_not contain_class('::forge_server::package').that_notifies('Class[::forge_server::service]')
    }
    it {
      should_not contain_class('::forge_server::config').that_notifies('Class[::forge_server::service]')
    }
  end

  context 'with scl => ruby193' do
    let(:params) { {
      :scl  => 'ruby193'
    } }

    it {
      should_not contain_package('puppet-forge-server')
    }
    it {
      should contain_exec('scl_install_forge_server').with(
        :command  => "scl enable ruby193 'gem install --bindir /usr/bin --no-rdoc --no-ri puppet-forge-server'"
      )
    }
    it {
      should contain_file('/etc/init.d/puppet-forge-server').with_content(/export LD_LIBRARY_PATH=.*\nexport GEM_PATH=.*\nexport PATH=.*\n/)
    }
  end

end
