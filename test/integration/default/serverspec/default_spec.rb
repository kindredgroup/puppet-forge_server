require 'serverspec'
require 'yaml'

set :backend, :exec

describe "Puppet" do
  it "should run without errors" do
    last_run = YAML.load_file('/var/lib/puppet/state/last_run_summary.yaml')
    expect(last_run['resources']['failed']).to eq(0)
    expect(last_run['resources']['failed_to_restart']).to eq(0)
    expect(last_run['events']['failure']).to eq(0)
  end
end

describe service('puppet-forge-server') do
  it { should be_running }
  it { should be_enabled.with_level(3) }
end

describe port(8080) do
  it { should be_listening }
end
