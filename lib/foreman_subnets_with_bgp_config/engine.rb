module ForemanSubnetsWithBgpConfig
  class Engine < ::Rails::Engine
    engine_name 'foreman_subnets_with_bgp_config'

    config.autoload_paths += Dir["#{config.root}/app"]

    initializer 'foreman_subnets_with_bgp_config.load_app_instance_data' do |app|
      ForemanSubnetsWithBgpConfig::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_subnets_with_bgp_config.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_subnets_with_bgp_config do
        Rails.logger.debug 'Register foreman_subnets_with_bgp_config plugin'
        requires_foreman '>= 3.3.0'

        [Subnet::Ipv4, Subnet::Ipv6].each do |s|
          parameter_filter s do |context|
            context.permit subnet_bgp_config_attributes: {}
          end
        end
      end
    end

    config.to_prepare do
      [Subnet::Ipv4, Subnet::Ipv6].each { |s| s.include ForemanSubnetsWithBgpConfig::ExtendSubnetWithBgpConfig }
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanSubnetsWithBgpConfig::Engine.load_seed
      end
    end
  end
end
