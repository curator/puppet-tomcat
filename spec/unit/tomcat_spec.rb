require 'spec_helper'

describe 'tomcat', :type => :class do
  context "When on unsupported operating system family" do
    let :facts do
      {
        :osfamily   =>  'GNU/Linux'
      }
    end

    it 'should send an *unsupported* error' do
      expect { should compile }.to raise_error(Puppet::Error, /Unsupported/)
    end

  end
end