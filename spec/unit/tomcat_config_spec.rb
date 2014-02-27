require 'spec_helper'

describe 'tomcat::config', :type => :class do
  let :params do
    {
      :java_opts    => ['-Djava.awt.headless=true', '-server'],
      :java_home    => '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64',
      :setenv_path  => '/usr/share/tomcat7/bin/setenv.sh',
      :tomcat_user  => 'tomcat7',
      :tomcat_group => 'tomcat7',
    }
  end

  it "should contain the config file with settings in it" do
    should contain_file('/usr/share/tomcat7/bin/setenv.sh').with({
        'ensure'  => 'file',
        'owner'   => 'tomcat7',
        'group'   => 'tomcat7',
        'mode'    => '0555'
      })
    should contain_file('/usr/share/tomcat7/bin/setenv.sh').with_content(/^JAVA_HOME\=\/usr\/lib\/jvm\/jre-1.7.0-openjdk.x86_64/)
    should contain_file('/usr/share/tomcat7/bin/setenv.sh').with_content(/^JAVA_OPTS\=\"-Djava.awt.headless=true -server/)
  end


end