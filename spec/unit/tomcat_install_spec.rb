require 'spec_helper'

describe 'tomcat::install', :type => :class do

  context 'When installing via archive' do
    let :params do
      {
        :package_provider   => 'archive',
      }
    end

    it 'should use tomcat::install::archive' do
      should contain_tomcat__install__archive()
    end
  end

  context 'When installing/managing java' do
    let :facts do
      { :osfamily => 'redhat', :operatingsystemrelease => '6.4'}
    end

    let :params  do
      { :install_java    => true }
    end

    it 'should install a java package' do
      should contain_package('java-1.7.0-openjdk')
      should contain_package('java-1.7.0-openjdk-devel')
    end
  end

end