begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

require './main.rb'

task :default do |t, args|
  main
end

task :run_specs do |t, args|
  Rake::Task["spec"].execute
end