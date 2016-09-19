class Address < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :addressable, :polymorphic => true
  
  validates_length_of       :country, :maximum => 10
  validates_length_of       :address1, :maximum => 50
  validates_length_of       :address2, :maximum => 50
  validates_length_of       :city, :maximum => 50
  validates_length_of       :state, :maximum => 10
  validates_format_of       :zip, :with => /^[0-9]{5}(-[0-9]{4})?$/, :allow_blank => true
end
