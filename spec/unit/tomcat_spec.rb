require 'spec_helper'

describe 'tomcat', :type => :class do

  context 'On an unsupported OS' do
    context 'When on an unsupported operating system family' do
      let :facts do
        {
          :osfamily     =>  'Gentoo'
        }
      end

      it 'should raise an *unsupported* error' do
        expect { should compile }.to raise_error(Puppet::Error, /Unsupported/)
      end
    end

    context 'When on a future supported operating system family' do
      let :facts do
        {
          :osfamily     => 'debian'
        }
      end

      it 'should raise a "coming soon" message' do
        expect { should compile }.to raise_error(Puppet::Error, /coming soon/)
      end
    end
  end

  context 'On a supported OS' do
    let :facts do
      {
        :osfamily       => 'redhat'
      }
    end

    context 'With anti-patterns' do
      context 'With an undefined package_name' do
        it 'should send raise an error because it is required' do
          expect { should compile }.to raise_error(Puppet::Error, /"package_name" parameter is required/)
        end

      end

      context 'With a non-digit-starting tomcat' do
        let :params do
          {
            :package_name   => 'apache-tomcat',
            :tomcat_version => 'something'
          }
        end

        it 'should raise an error' do
          expect { should compile }.to raise_error(Puppet::Error, /"tomcat_version" is required and must start with a digit/)
        end
      end

    end

    context 'When things are setup properly' do
      let :params do
        {
          :package_name   => 'apache-tomcat',
          :tomcat_version => '7.0.50',
          :setenv_path    => '/usr/share/tomcat7/bin/setenv.sh',
          :manage_setenv  => true
        }
      end

      it 'should commit to installing' do
        expect contain_tomcat__install()
      end

      it 'should do some configuration' do
        expect contain_tomcat__config()
      end

    end # End things are setup properly

  end # End supported OS
end # End describe
