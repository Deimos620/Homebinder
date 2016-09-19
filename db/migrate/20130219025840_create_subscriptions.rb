class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :binder_id
      t.integer :subscription_type_id
      t.date :expires_on
      t.timestamps
    end
  end
end
