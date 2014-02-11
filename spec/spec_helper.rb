dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')

require 'puppet'
require 'rspec'
require 'spec/autorun'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera-puppet-helper'

# We need this because the RAL uses 'should' as a method.  This
# allows us the same behaviour but with a different method name.
class Object
    alias :must :should
end
