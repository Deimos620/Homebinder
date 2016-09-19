class AddCustomerIdToSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :stripe_token
    add_column :subscriptions, :customer_id, :string
  end
end
