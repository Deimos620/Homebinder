class RemovePdf < ActiveRecord::Migration
  def change
    drop_table :pdfs
  end
end