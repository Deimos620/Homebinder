class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string      :company_name 
      t.string      :application_name
      t.string      :key
      t.string      :contact_email
      t.timestamps
    end
  end
end
