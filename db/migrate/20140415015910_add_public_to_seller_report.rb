class AddPublicToSellerReport < ActiveRecord::Migration
  def change
    add_column :seller_reports, :public, :boolean
  end
end
