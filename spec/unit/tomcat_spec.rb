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

    let :params do
      {
        :tomcat_version => '7.0.50'
      }
    end

    context 'With anti-patterns' do
      context 'With an undefined package_name' do
        it 'should send raise an error because it is required' do
          expect { should compile }.to raise_error(Puppet::Error, /"package_name" parameter is required/)
        end

      end

      context 'With a java_opts that is not an array' do
        let :params do
          {
            :package_name => 'apache-tomcat',
            :java_opts    => 'peaches'
          }
        end

        it 'should raise an error because it has to be an array' do
          expect { should compile }.to raise_error(Puppet::Error, /"java_opts" parameter must be an array/)
        end
      end
    end

    context 'When things are setup properly' do
      let :params do
        {
          :package_name => 'apache-tomcat'
        }
      end

      pending 'It should run the install'
      pending 'It should do some configuration'

    end # End things are setup properly

  end # End supported OS
end # End describe
