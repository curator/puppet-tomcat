require 'spec_helper'

describe 'tomcat::install', :type => :class do

  describe 'On RedHat-ish' do
    let :facts do
      { :osfamily => 'redhat', :operatingsystemrelease => '6.4'}
    end

    context 'When installing/managing java' do
      let :params_data  do
        { :install_java    => true }
      end

      it 'should install a java package' do
        should contain_package('java-1.7.0-openjdk')
        should contain_package('java-1.7.0-openjdk-devel')
      end
    end
  end # End RedHat-ish

end