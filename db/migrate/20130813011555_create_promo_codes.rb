class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.references    :partner
      t.string        :coupon_id
      t.integer       :percent_off
      t.integer       :amount_off
      t.date          :start_date
      t.date          :end_date
      t.boolean       :active
      t.boolean       :RevenueShare
      t.string        :share_type
      t.integer       :max_number_of_uses
      t.integer       :number_of_uses  
      t.timestamps
    end
  end
end
