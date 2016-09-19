class CreateImages < ActiveRecord::Migration
  
  def change
    create_table :images do |t|
      t.references  :imageable, :polymorphic => :true
      t.string      :location
      t.string      :key
      t.string      :bucket
      t.string      :etag
      t.string      :details
      t.integer     :created_by
      t.timestamps
    end
  end
  
end
