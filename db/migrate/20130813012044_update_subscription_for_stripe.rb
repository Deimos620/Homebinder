class UpdateSubscriptionForStripe < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_token, :string
    add_column :subscriptions, :plan_id, :string
    add_column :subscriptions, :coupon_id, :string
    remove_column :subscriptions, :subscription_type_id
  end
end
