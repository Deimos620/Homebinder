class CreatePaints < ActiveRecord::Migration
  def change
    create_table :paints do |t|
      t.integer       :created_by
      t.references    :binder
      t.string        :name
      t.integer       :paint_manufacturer_id
      t.string        :code
      t.string        :makeup
      t.string        :details
      t.integer       :paint_type_id
      t.timestamps
    end
  end
end
