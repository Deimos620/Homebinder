class AddPublicInfoToBinder < ActiveRecord::Migration
  def change
    add_column :binders, :buyers_url, :string
    add_column :binders, :buyers_public, :boolean
  end
end
