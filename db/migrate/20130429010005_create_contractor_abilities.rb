class CreateContractorAbilities < ActiveRecord::Migration
  def change
    create_table :contractor_abilities do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
