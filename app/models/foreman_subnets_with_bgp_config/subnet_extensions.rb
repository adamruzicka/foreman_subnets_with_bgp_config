module ForemanSubnetsWithBGPConfig
  module SubnetExtensions
    extend ActiveSupport::Concern

    included do
      has_one :subnet_bgp_config,
        inverse_of: :subnet,
        dependent: :destroy
      accepts_nested_attributes_for :subnet_bgp_config,
        reject_if: :all_blank,
        update_only: true
    end

    # For some reason, the subclasses Subnet::Ipv4 and Subnet::Ipv6
    #   don't inherit the :subnet_bgp_config association.
    # As such, I have to explicitly define methods to get the nested attributes.
    def as_local
      subnet.subnet_bgp_config.as_local
    end

    def as_remote
      subnet.subnet_bgp_config.as_remote
    end

    def ip_remote
      subnet.subnet_bgp_config.ip_remote
    end
  end
end
