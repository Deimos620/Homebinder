class AddBinderToUploads < ActiveRecord::Migration
  def change
    add_column :documents, :binder_id, :integer
    add_column :images, :binder_id, :integer
  end
end
