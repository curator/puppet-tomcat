require 'spec_helper'

describe 'tomcat::install::staging', :type => :class do

  let :params_data  do
    {
      :tar_source_uri => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
      :version        => '7.0.50',
      :unpack_dir     => '/usr/local/src'
    }
  end

  it "Should download the specified version's tar ball" do
   should contain_staging__file('apache-tomcat-7.0.50')
  end

  it "Should extract the tar ball" do
    should contain_staging__extract('apache-tomcat-7.0.50.tar.gz')
  end

  pending 'Create the specified tomcat user'
  pending 'Chown the directories to the tomcat user'
  pending 'Set perms on tomcat directory(ies)'
  describe '... on RedHat-ish' do
    pending 'Place init script'
    pending 'Set perms on init script'
    pending 'Chkconfig init script on'
  end

end