require 'spec_helper'
describe 'forge_server' do

  on_supported_os.each do |os, facts|
    puts "stdout-debug OS: '#{os}'  -- operatingsystemmajrelease: '#{facts[:operatingsystemmajrelease]}'"
    context "with defaults for all parameters (on #{os})" do
      let(:facts) do
        facts
      end

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


    context "with single module path and proxy (on #{os})" do
      let(:params) { {
        :module_directory => '/dir1',
        :proxy            => 'proxy1'
      } }

      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \\"\/dir1\\""\n\n/)
        }
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\n\n/)
        }
      when 'Debian'
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \/dir1"\n\n/)
        }
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\n\n/)
        }
       end
    end


    context "with multiple module paths and proxies (on #{os})" do
      let(:params) { {
        :module_directory => ['/dir1', '/dir2'],
        :proxy            => ['proxy1', 'proxy2']
      } }

      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \\"\/dir1\\""\nPARAMS="\${PARAMS} --module-dir \\"\/dir2\\""\n/)
        }
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\nPARAMS="\${PARAMS} --proxy proxy2"\n/)
        }
      when 'Debian'
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --module-dir \/dir1"\nPARAMS="\${PARAMS} --module-dir \/dir2"\n/)
        }
        it {
          should contain_file('/etc/default/puppet-forge-server').with_content(/PARAMS="\${PARAMS} --proxy proxy1"\nPARAMS="\${PARAMS} --proxy proxy2"\n/)
        }
      end
    end


    context "with service_refresh => false (on #{os})" do
      let(:params) { {
        :service_refresh  => false
      } }

      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }
      it {
        should_not contain_class('::forge_server::package').that_notifies('Class[::forge_server::service]')
      }
      it {
        should_not contain_class('::forge_server::config').that_notifies('Class[::forge_server::service]')
      }
    end


    context "with scl => ruby193 (on #{os})" do
      let(:params) { {
        :scl  => 'ruby193'
      } }

      let(:facts) do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
        it { should compile.with_all_deps }
        it {
          should_not contain_package('puppet-forge-server')
        }
        it {
          should contain_exec('scl_install_forge_server').with(
            :command  => "scl enable ruby193 'gem install --bindir /usr/bin --no-rdoc --no-ri puppet-forge-server'"
          )
        }
        if facts[:release] == 6
          it {
            should contain_file('/etc/init.d/puppet-forge-server').with_content(/export LD_LIBRARY_PATH=.*\nexport GEM_PATH=.*\nexport PATH=.*\n/)
          }
        end
      when 'Debian'
        it { should_not compile }
      end
    end


    context "with scl => ruby193, scl_install_timeout => 60000, scl_install_retries => 10 (on #{os})" do
      let(:params) { {
        :scl                 => 'ruby193',
        :scl_install_timeout => 60000,
        :scl_install_retries => 10
      } }

      let(:facts) do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
        it { should compile.with_all_deps }
        it { should contain_exec('scl_install_forge_server').with_timeout(60000) }
        it { should contain_exec('scl_install_forge_server').with_tries(10) }
      when 'Debian'
        it { should_not compile }
      end
    end
  end
end
