# Copyright (c) 2015 Solano Labs All Rights Reserved
#

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--color"
end
task :default => :spec
