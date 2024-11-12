module ForemanSubnetsWithBGPConfig
  module SubnetExtensions
    def self.included (base)
      has_one :subnet_bgp_config,
        inverse_of: :subnet,
        dependent: :destroy
      accepts_nested_attributes_for :subnet_bgp_config,
        reject_if: :all_blank,
        update_only: true
    end
  end
end
