require 'spec_helper'

describe 'tomcat', :type => :class do

  let :params_data do
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

    it 'should send an *unsupported* error' do
      expect { should compile }.to raise_error(Puppet::Error, /Unsupported/)
    end
  end

  context 'When on a future supported operating system family' do
    let :facts do
      {
        :osfamily   => 'debian'
      }
    end

    it 'should send a "coming soon" message' do
      expect { should compile }.to raise_error(Puppet::Error, /coming soon/)
    end
  end

  describe 'On RedHat-ish' do
    let :facts do
      { :osfamily => 'redhat', :operatingsystemrelease => '6.4'}
    end

    context 'When installing/managing java' do
      let :hiera_data  do
        { tomcat::install_java    => true }
      end

      it 'should install a java package' do
        should contain_package('java-1.7.0-openjdk')
        should contain_package('java-1.7.0-openjdk-devel')
      end

    end
  end # End RedHat-ish

end