class CreateBinderContractors < ActiveRecord::Migration
  def change
    create_table :binder_contractors do |t|
      t.references    :binder
      t.references    :contractor
      t.integer       :created_by
      t.timestamps
    end
  end
end
