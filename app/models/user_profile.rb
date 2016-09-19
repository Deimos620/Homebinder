class UserProfile < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :address, :as => :addressable
  
  accepts_nested_attributes_for :address
  
  phony_normalize :home_phone, :default_country_code => 'US'
  phony_normalize :mobile_phone, :default_country_code => 'US'
  
  validates_length_of :first_name, :maximum => 50
  validates_length_of :last_name, :maximum => 50
  validates_plausible_phone :home_phone, :presence => false
  validates_plausible_phone :mobile_phone, :presence => false
  validates_length_of :sex, :maximum => 1
  
  def display_name
    if self.first_name && self.last_name
      "#{self.first_name} #{self.last_name}"
    else if self.first_name
      self.first_name
    end
  end
  end
  
end
