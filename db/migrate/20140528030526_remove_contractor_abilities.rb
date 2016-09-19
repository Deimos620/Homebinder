class RemoveContractorAbilities < ActiveRecord::Migration
  def change
    drop_table :contractor_abilities
    drop_table :contractor_contractor_abilities
  end
end
