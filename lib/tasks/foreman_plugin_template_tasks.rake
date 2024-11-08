namespace :foreman_subnets_with_bgp_config do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

namespace :foreman_subnets_with_bgp_config do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_subnets_with_bgp_config) do |task|
        task.patterns = ["#{ForemanCnames::Engine.root}/app/**/*.rb",
                         "#{ForemanCnames::Engine.root}/lib/**/*.rb"]
      end
    rescue LoadError
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_subnets_with_bgp_config'].invoke
  end
end

load 'tasks/jenkins.rake'
Rake::Task['jenkins:unit'].enhance ['foreman_subnets_with_bgp_config:rubocop'] if Rake::Task.task_defined?(:'jenkins:unit')
