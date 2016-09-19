class DropSubscriptionType < ActiveRecord::Migration
  def change
    drop_table :subscription_types
  end
end
