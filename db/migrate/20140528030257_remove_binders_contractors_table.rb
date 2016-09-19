class RemoveBindersContractorsTable < ActiveRecord::Migration
  def change
    drop_table :binders_contractors
  end
end
