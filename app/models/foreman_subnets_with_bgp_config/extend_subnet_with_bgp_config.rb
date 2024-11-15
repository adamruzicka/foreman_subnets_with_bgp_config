module ForemanSubnetsWithBgpConfig
  module ExtendSubnetWithBgpConfig
    extend ActiveSupport::Concern

    included do
      has_one :subnet_bgp_config,
        inverse_of: :subnet,
        dependent: :destroy,
        class_name: '::ForemanSubnetsWithBgpConfig::SubnetBgpConfig'
      accepts_nested_attributes_for :subnet_bgp_config,
        reject_if: :all_blank,
        update_only: true
    end
  end
end
