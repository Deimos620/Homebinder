class AddLastRecallDateAndUpcToAppliances < ActiveRecord::Migration
  def change
    add_column :appliances, :last_recall_check, :date
    add_column :appliances, :upc, :string
  end
end
