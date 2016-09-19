class DropCouponFromSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :coupon_id
    remove_column :subscriptions, :status
  end
end
