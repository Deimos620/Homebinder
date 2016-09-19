class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references  :binder
      t.string      :name
      t.string      :details
      t.boolean     :deductable
      t.integer     :created_by
      t.timestamps
    end
  end
end
