require 'rake'
require 'rake/testtask'

task :default => :test

desc "Run the unit tests in test/unit"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end