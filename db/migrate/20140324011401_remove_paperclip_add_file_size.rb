class RemovePaperclipAddFileSize < ActiveRecord::Migration
  def change
    #remove_attachment :documents, :file
    #remove_attachment :images, :file
    add_column :documents, :file_size, :integer
    add_column :images, :file_size, :integer
  end
end
