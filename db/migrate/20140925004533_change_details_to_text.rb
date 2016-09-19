class ChangeDetailsToText < ActiveRecord::Migration
  def change
    change_column :appliances, :details, :text, :limit => nil
    change_column :areas, :details, :text, :limit => nil
    change_column :binder_contractors, :details, :text, :limit => nil
    change_column :contractors, :details, :text, :limit => nil
    change_column :documents, :details, :text, :limit => nil
    change_column :finishes, :details, :text, :limit => nil
    change_column :images, :details, :text, :limit => nil
    change_column :inventory_items, :details, :text, :limit => nil
    change_column :logos, :details, :text, :limit => nil
    change_column :maintenance_items, :details, :text, :limit => nil
    change_column :notes, :content, :text, :limit => nil
    change_column :paints, :details, :text, :limit => nil
    change_column :projects, :details, :text, :limit => nil
    change_column :properties, :details, :text, :limit => nil
    change_column :receipts, :details, :text, :limit => nil
    change_column :structures, :details, :text, :limit => nil
  end
end
