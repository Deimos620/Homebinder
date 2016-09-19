class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string      :name
      t.integer     :created_by
      t.boolean     :verified
      t.timestamps
    end
  end
end
