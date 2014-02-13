require 'spec_helper'

describe 'tomcat::install::archive', :type => :class do

  let :params_data  do
    {
      :archive_source_uri   => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
      :version              => '7.0.50',
      :archive_download_dir => '/usr/local/src'
    }
  end

  it "Should download and untar the specified version's tarball" do
   should contain_archive('apache-tomcat-7.0.50')
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