#!/bin/bash

# Install/update foreman_subnets_with_bgp_config on an KIT/SDM Satellite server

# Execute this script from the root directory of a clone of the Git repository!
# If need be, change PATH such that the appropriate gem executable is used!

# Make Satellite load foreman_subnets_with_bgp_config...
echo 'gem "foreman_subnets_with_bgp_config"' >~foreman/bundler.d/foreman_subnets_with_bgp_config.rb
chown foreman: ~foreman/bundler.d/foreman_subnets_with_bgp_config.rb

# Build new Gem file
gem build foreman_subnets_with_bgp_config.gemspec

# Uninstall previous versions
gem uninstall -a foreman_subnets_with_bgp_config

# Install new version without dependencies, as to not change any Foreman internal Gems
gem install --ignore-dependencies foreman_subnets_with_bgp_config-*.gem
/bin/rm foreman_subnets_with_bgp_config-*.gem # Cleanup to avoid future conflicts

# Apply any database updates necessary
foreman-rake db:migrate

# Restart foreman at your own risk...
# foreman-maintain service restart
