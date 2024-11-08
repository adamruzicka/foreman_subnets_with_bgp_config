module ForemanSubnetsWithBGPConfig
  module SubnetExtensions
    extend ActiveSupport::Concern

    included do
      has_one :subnet_bgp_config,
        dependent: :destroy
      accepts_nested_attributes_for :subnet_bgp_config,
        reject_if: :all_blank,
        update_only: true
    end
  end
end
