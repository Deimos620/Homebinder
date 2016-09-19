class CreateMaintenanceItems < ActiveRecord::Migration
  def change
    create_table :maintenance_items do |t|
      t.references  :binder
      t.references  :appliance
      t.references  :area
      t.references  :structure
      t.references  :maintenance_type
      t.references  :maintenance_cycle
      t.string      :name
      t.string      :details
      t.integer     :interval
      t.integer     :created_by
      t.timestamps
    end
  end
end
