class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer     :store_id
      t.date        :date
      t.money       :price
      t.integer     :created_by
      t.references  :purchaseable, :polymorphic => true
      t.timestamps
    end
  end
end
