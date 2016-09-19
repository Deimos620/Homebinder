class CreateConstructionStyles < ActiveRecord::Migration
  def change
    create_table :construction_styles do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
