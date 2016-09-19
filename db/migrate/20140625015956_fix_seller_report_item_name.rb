class FixSellerReportItemName < ActiveRecord::Migration
  def change
    drop_table :SellerReportItems
    
    create_table :seller_report_items do |t|
      t.references :seller_reportable, :polymorphic => true
      t.boolean :include
      t.integer :sort_index
    end
  end
end
