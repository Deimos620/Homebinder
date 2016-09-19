class CreateMaintenanceCycles < ActiveRecord::Migration
  def change
    create_table :maintenance_cycles do |t|
      t.string    :name
    end
  end
end
