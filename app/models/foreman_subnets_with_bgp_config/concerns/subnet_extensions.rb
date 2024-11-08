module ForemanSubnetsWithBGPConfig
  module SubnetExtensions
    extend ActiveSupport::Concern

    included do
      has_one :subnet_bgp_config, allow_destroy: true
      accepts_nested_attributes_for :subnet_bgp_config, reject_if: :all_blank
    end
  end
end
