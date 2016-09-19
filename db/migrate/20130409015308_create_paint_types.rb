class CreatePaintTypes < ActiveRecord::Migration
  def change
    create_table :paint_types do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
