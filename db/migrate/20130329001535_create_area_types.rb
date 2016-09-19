class CreateAreaTypes < ActiveRecord::Migration
  def change
    create_table :area_types do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
