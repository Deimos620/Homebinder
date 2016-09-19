class CreateSellerReportResources < ActiveRecord::Migration
  def change
    create_table :SellerReportItems do |t|
      t.references :seller_reportable, :polymorphic => true
      t.boolean :include
      t.integer :sort_index
    end
  end
end
