class CreateStructures < ActiveRecord::Migration
  
  def change
    create_table :structures do |t|
      t.references :binder
      t.string  :name
      t.integer :year_built
      t.integer :beds
      t.decimal :baths
      t.integer :sq_ft
      t.integer :building_type_id
      t.integer :construction_style_id
      t.integer :construction_type_id
      t.integer :heat_type_id
      t.integer :heat_source_id
      t.string  :details
      t.integer :created_by
      t.timestamps
    end
  end
  
end
