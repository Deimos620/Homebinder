class DropPublicInfoFromBinders < ActiveRecord::Migration
  def change
    remove_column :binders, :buyers_url
    remove_column :binders, :buyers_public
  end
end
