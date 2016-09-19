class CreateBindersContractors < ActiveRecord::Migration
  def change
    create_table :binders_contractors, :id => false do |t|
      t.references :binder
      t.references :contractor
    end
  end
end
