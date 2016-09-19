class CreateFinishes < ActiveRecord::Migration
  def change
    create_table :finishes do |t|
      t.integer       :binder_id
      t.string        :name
      t.integer       :finish_make_id
      t.integer       :finish_model_id
      t.string        :style_color
      t.string        :details
      t.integer       :created_by
      t.timestamps
    end
  end
end
