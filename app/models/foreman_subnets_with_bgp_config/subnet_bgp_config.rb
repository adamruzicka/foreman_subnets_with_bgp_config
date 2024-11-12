require 'ipaddr'

module ForemanSubnetsWithBGPConfig
  class SubnetBGPConfig < ActiveRecord::Base
    self.table_name = 'subnet_bgp_configs'
    belongs_to :subnet, inverse_of: :subnet_bgp_config

    validates :as_local,
      inclusion: { in: 4200001000...4200002000 },
      allow_blank: true
    validates :as_remote,
      inclusion: {
        in: [65529, 65530],
        message: "%{value} must bei either 65529 or 65530",
      },
      allow_blank: true
    validates_each :ip_remote do |record, attr, value|
      return true if value.blank?
      begin
        IPAddr.new value
      rescue IPAddr::InvalidAddressError
        record.errors.add attr, 'Not a valid IP address'
      end
    end

    validate :remote_ip_matches_subnet_type
    validate :everything_or_nothing_is_blank
  end

  def remote_ip_matches_subnet_type
    return true if ip_remote.blank?

    errors.add :ip_remote, "#{ip_remote} does not fit the subnet's protocol (#{subnet.network_type})" if
      IPAddr.new(:ip_remote).family != IPAddr.new(subnet.network).family
  end

  def everything_or_nothing_is_blank
    subnet.errors.add :base, 'All BGP settings must be either blank or present' unless
      [as_local, as_remote, ip_remote].all(&:blank?) || [as_local, as_remote, ip_remote].all(&:present?)
  end
end
