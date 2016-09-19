class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references  :documentable, :polymorphic => :true
      t.string      :name
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
