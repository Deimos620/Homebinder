class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.integer     :contractor_type_id
      t.string      :name
      t.string      :phone
      t.string      :email
      t.string      :url
      t.string      :account_number
      t.string      :contact
      t.string      :details
      t.integer     :created_by
      t.boolean     :verified
      t.timestamps
    end
  end
end
