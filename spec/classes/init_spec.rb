require 'spec_helper'
describe 'forge_server' do

  context 'with defaults for all parameters' do
    it { should contain_class('forge_server') }
  end
end
