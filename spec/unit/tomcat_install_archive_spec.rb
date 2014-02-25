require 'spec_helper'

describe 'tomcat::install::archive', :type => :class do

  let :params  do
    {
      :package_name           => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
      :version                => '7.0.50',
      :archive_download_dir   => '/usr/local/src',
      :manage_group           => true,
      :tomcat_group           => 'conehead',
      :manage_user            => true,
      :tomcat_user            => 'conehead',
      :archive_target_dir     => '/usr/share',
      :remove_default_apps    => true,
      :remove_default_manager => true,
      :symlink_to_maj_version => true,
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
    should contain_file('/usr/share/apache-tomcat-7.0.50')
  end

  it 'should remove default apps, if remove_default_apps is true' do
    should contain_file('/usr/share/apache-tomcat-7.0.50/webapps/docs')
    should contain_file('/usr/share/apache-tomcat-7.0.50/webapps/examples')
    should contain_file('/usr/share/apache-tomcat-7.0.50/webapps/ROOT')
  end

  it 'should remove manager, if remove_default_manager is false' do
    should contain_file('/usr/share/apache-tomcat-7.0.50/webapps/manager')
    should contain_file('/usr/share/apache-tomcat-7.0.50/webapps/host-manager')
  end

  it 'should create a user-space startup/shutdown symlink' do
    should contain_file('/usr/bin/dtomcat7')
  end

  it 'should create a symlink to major version director' do
    should contain_file('/usr/share/tomcat7')
  end

end