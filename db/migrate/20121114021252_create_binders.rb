class CreateBinders < ActiveRecord::Migration
  
  def change
    create_table :binders do |t|
      t.string :name
      t.boolean :primary
      t.boolean :active, :default => true
      t.integer :created_by
      t.timestamps
    end
    
  end
  
end
