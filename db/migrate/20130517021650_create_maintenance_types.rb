class CreateMaintenanceTypes < ActiveRecord::Migration
  def change
    create_table :maintenance_types do |t|
      t.string      :name
      t.integer     :interval
      t.integer     :maintenance_cycle_id
      t.integer     :created_by
      t.boolean     :verified
    end
  end
end
