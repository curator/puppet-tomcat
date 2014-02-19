require 'spec_helper'

describe 'tomcat', :type => :class do

  let :params do
    {
      :tomcat_version   => '7.0.50',
      :java_home        => '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64'
    }
  end

  context 'When on an unsupported operating system family' do
    let :facts do
      {
        :osfamily   =>  'Gentoo'
      }
    end

    it 'should raise an *unsupported* error' do
      expect { should compile }.to raise_error(Puppet::Error, /Unsupported/)
    end
  end

  context 'When on a future supported operating system family' do
    let :facts do
      {
        :osfamily   => 'debian'
      }
    end

    it 'should raise a "coming soon" message' do
      expect { should compile }.to raise_error(Puppet::Error, /coming soon/)
    end
  end

  context 'With an undefined package_name' do
    let :params do
      {
        :package_name => undef
      }
    end

    it 'should send raise an error because it is required' do
      expect { should compile }.to raise_error(Puppet::Error, /"package_name" parameter is required/)
    end
  end

end
