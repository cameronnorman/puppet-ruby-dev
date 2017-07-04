require 'spec_helper'
describe 'rvm' do
  context 'with default values for all parameters' do
    it { should contain_class('rvm') }
  end
end
