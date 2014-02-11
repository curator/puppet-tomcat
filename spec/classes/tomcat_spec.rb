require 'spec_helper'

describe 'tomcat', :type => :class do
  context "When on unsupported operating system family" do
    let :facts do
      {
        :osfamily   =>  'GNU/Linux'
      }
    end
  end
end