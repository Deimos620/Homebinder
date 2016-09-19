class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.references :user
      t.references :binder
      t.string :transfer_to
      t.string :transfer_type
      t.string :status
      t.timestamps
    end
  end
end
