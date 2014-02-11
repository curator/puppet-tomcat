require 'bundler'
require 'rake/clean'

CLEAN.include('spec/fixtures/manifests/', 'spec/fixtures/modules/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'rspec-system/rake_task'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send("disable_80chars")

ENV['MODULEPATH'] = 'spec/fixtures/modules/'

task :librarian_spec_prep do
 sh "librarian-puppet install --path=spec/fixtures/modules/"
end

task :spec_prep => :librarian_spec_prep
task :spec_system => :clean

task :default => [:clean, :spec]