class CreateFinishModels < ActiveRecord::Migration
  def change
    create_table :finish_models do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
