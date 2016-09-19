class CreateFinishMakes < ActiveRecord::Migration
  def change
    create_table :finish_makes do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
