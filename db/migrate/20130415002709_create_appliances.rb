class CreateAppliances < ActiveRecord::Migration
  def change
    create_table :appliances do |t|
      t.references  :binder
      t.string      :name
      t.integer     :appliance_type_id
      t.integer     :appliance_manufacturer_id
      t.integer     :appliance_model_id
      t.string      :model_number
      t.string      :serial_no
      t.string      :warranty
      t.string      :user_guide_url
      t.string      :details
      t.integer     :created_by
      t.timestamps
    end
  end
end
