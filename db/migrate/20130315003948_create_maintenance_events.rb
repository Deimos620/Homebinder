class CreateMaintenanceEvents < ActiveRecord::Migration
  def change
    create_table :maintenance_events do |t|
      t.references  :maintenance_item
      t.references  :contractor
      t.date        :do_date
      t.date        :completed_date
      t.integer     :created_by
      t.timestamps
    end
  end
end
