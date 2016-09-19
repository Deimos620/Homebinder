class CreateContractorsContractorsAbilities < ActiveRecord::Migration
  def change
    create_table :contractor_contractor_abilities, :id => false do |t|
      t.references :contractor
      t.references :contractor_ability
    end
  end
end
