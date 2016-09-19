class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references  :taggable, :polymorphic => :true
      t.string      :tag
      t.boolean     :auto_generated, :default => true
      t.integer     :created_by
      t.timestamps
    end
  end
end
