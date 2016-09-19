class CreateApplianceManufacturers < ActiveRecord::Migration
  def change
    create_table :appliance_manufacturers do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
