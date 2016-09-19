class CreateInventoryItemTypes < ActiveRecord::Migration
  def change
    create_table :inventory_item_types do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
