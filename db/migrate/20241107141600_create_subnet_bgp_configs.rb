# Never change this file's name or content, once it has been applied to any database!
# If the change is inappropriate, add more migration files to recktify that!
class CreateSubnetBgpConfigs < ActiveRecord::Migration[4.2]
  def change
    create_table :subnet_bgp_configs do |t|
      # A primary key id column is added by default
      t.belongs_to :subnet, null: false, foreign_key: true
      # Need to keep a copy of the subnet's type for polymorphic association
      t.string :type, limit: 255, null: false
      t.integer :as_local
      t.integer :as_remote
      t.string :ip_remote, limit: 39 # Maximum length of an IPv6 address
      t.timestamps
    end
  end
end
