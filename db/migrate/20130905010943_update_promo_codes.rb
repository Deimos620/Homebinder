class UpdatePromoCodes < ActiveRecord::Migration
  def change
    remove_column :promo_codes, :percent_off
    remove_column :promo_codes, :amount_off
    remove_column :promo_codes, :start_date
    remove_column :promo_codes, :end_date
    remove_column :promo_codes, :max_number_of_uses
    remove_column :promo_codes, :number_of_uses
  end
end
