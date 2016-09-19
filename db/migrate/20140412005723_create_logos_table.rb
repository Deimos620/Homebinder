class CreateLogosTable < ActiveRecord::Migration
  def up
    create_table :logos do |t|
      t.references  :partner
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
