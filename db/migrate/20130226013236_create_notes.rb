class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string      :content
      t.references  :notable, :polymorphic => true
      t.integer     :access_level
      t.integer     :created_by
      t.timestamps
    end
  end
end
