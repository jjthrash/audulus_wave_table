require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :clean do
  FileUtils.rm(Dir.glob("./*.gem"))
end

task :build do
  system("gem build build_audulus_nodes.gemspec")
end

desc "Run tests"
task :default => :test
