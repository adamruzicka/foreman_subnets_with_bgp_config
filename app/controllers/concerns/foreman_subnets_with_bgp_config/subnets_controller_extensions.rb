module ForemanSubnetsWithBgpConfig
  module SubnetsControllerExtensions
    def new
      super
      @subnet.build_subnet_bgp_config
    end
  end
end
