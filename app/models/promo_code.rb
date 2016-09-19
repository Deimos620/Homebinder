class PromoCode < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to    :partner
  
  validates_presence_of :coupon_id
  validates_uniqueness_of :coupon_id
end
