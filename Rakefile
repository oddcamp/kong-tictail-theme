require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end

task :default => ['spec']

require "./app"
require "./lib/tictail"
Dir.glob('lib/tasks/*.rake').each { |r| load r}

