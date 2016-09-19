class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.references  :binder
      t.references  :inventory_item_type
      t.string      :name
      t.money       :value
      t.string      :details
      t.integer     :created_by
      t.timestamps
    end
  end
end
