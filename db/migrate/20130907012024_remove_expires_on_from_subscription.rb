class RemoveExpiresOnFromSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :expires_on
  end
end
