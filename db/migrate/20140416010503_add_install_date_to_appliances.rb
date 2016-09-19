class AddInstallDateToAppliances < ActiveRecord::Migration
  def change
    add_column :appliances, :install_date, :date
  end
end
