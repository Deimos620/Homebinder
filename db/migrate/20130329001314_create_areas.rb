class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.references  :binder
      t.string      :name
      t.integer     :structure_id
      t.string      :details
      t.string      :dimensions
      t.integer     :area_type_id
      t.integer     :created_by
      t.timestamps
    end
  end
end
