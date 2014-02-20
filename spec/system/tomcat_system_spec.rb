require 'spec_helper_system'

describe 'base tests:' do
  it 'should have the module to test' do
    # just bail if the module we're testing isn't there
    shell("ls /etc/puppet/modules/tomcat") do |r|
      r.exit_code.should eq(0)
      r.stdout.should match /Modulefile/
      r.stderr.should eq('')
    end
  end

  it 'should make sure a puppet agent has run' do
    puppet_agent do |r|
      r.stderr.should eq('')
      r.exit_code.should eq(0)
    end
  end

  # Using puppet_apply as a helper
  it 'my class should work with no errors' do
    pp = <<-EOS
      class { 'tomcat':
        package_name     => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
        package_provider => 'archive'
      }
    EOS

    # Run it twice and test for idempotency
    puppet_apply(pp) do |r|
      r.exit_code.should_not == 1
      r.refresh
      r.exit_code.should be_zero
    end
  end
end
