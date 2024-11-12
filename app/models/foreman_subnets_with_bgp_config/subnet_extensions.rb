module ForemanSubnetsWithBGPConfig
  module SubnetExtensions
    extend ActiveSupport::Concern

    included do
      has_one :subnet_bgp_config,
        as: :bgp_config_settings,
        dependent: :destroy
      has_one :bgp_config,
        through: :subnet_bgp_config,
        dependent: :destroy
      accepts_nested_attributes_for :bgp_config,
        reject_if: :all_blank,
        update_only: true
    end
  end
end
