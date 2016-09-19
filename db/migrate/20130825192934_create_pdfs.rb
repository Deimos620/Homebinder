class CreatePdfs < ActiveRecord::Migration
  
  def change
    create_table :pdfs do |t|
      t.references  :pdfable, :polymorphic => :true
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
