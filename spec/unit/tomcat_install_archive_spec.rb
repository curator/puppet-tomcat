require 'spec_helper'

describe 'tomcat::install::archive', :type => :class do

  let :params  do
    {
      :archive_source_uri     => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
      :version                => '7.0.50',
      :archive_download_dir   => '/usr/local/src',
      :manage_group           => true,
      :tomcat_group           => 'conehead',
      :manage_user            => true,
      :tomcat_user            => 'conehead',
      :archive_target_dir     => '/usr/share/tomcat7',
      :remove_default_apps    => true,
      :remove_default_manager => true
    }
  end

  it "should create group and user if not already defined, if manage_group and manage_user is true" do
    should contain_group('conehead')
    should contain_user('conehead')
  end

  it "Should download and untar the specified version's tarball" do
   should contain_archive('apache-tomcat-7.0.50')
  end

  it 'should chown the directories to the specified tomcat user' do
    should contain_file('/usr/share/tomcat7')
  end

  it 'should remove default apps, if remove_default_apps is true' do
    should contain_file('/usr/share/tomcat7/webapps/docs')
    should contain_file('/usr/share/tomcat7/webapps/examples')
    should contain_file('/usr/share/tomcat7/webapps/ROOT')
  end

  it 'should remove manager, if remove_default_manager is false' do
    should contain_file('/usr/share/tomcat7/webapps/manager')
    should contain_file('/usr/share/tomcat7/webapps/host-manager')
  end

  describe '... on RedHat-ish' do
    pending 'Place init script'
    pending 'Set perms on init script'
    pending 'Chkconfig init script on'
  end

end