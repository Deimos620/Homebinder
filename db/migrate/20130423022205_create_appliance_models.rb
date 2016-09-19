class CreateApplianceModels < ActiveRecord::Migration
  def change
    create_table :appliance_models do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
