require 'spec_helper'

describe 'tomcat::install', :type => :class do

  describe 'When installing via archive' do
    let :params do
      {
        :package_provider   => 'archive',
      }
    end

    it 'should use tomcat::install::archive' do
      should contain_tomcat__install__archive()
    end
  end

  describe 'On RedHat-ish' do
    let :facts do
      { :osfamily => 'redhat', :operatingsystemrelease => '6.4'}
    end

    context 'When installing/managing java' do
      let :params  do
        { :install_java    => true }
      end

      it 'should install a java package' do
        should contain_package('java-1.7.0-openjdk')
        should contain_package('java-1.7.0-openjdk-devel')
      end
    end
  end # End RedHat-ish


end