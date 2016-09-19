class CreateHeatSources < ActiveRecord::Migration
  def change
    create_table :heat_sources do |t|
      t.string  :name
      t.integer :created_by
      t.boolean :verified
    end
  end
end
