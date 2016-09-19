class Property < ActiveRecord::Base
  resourcify
  
  # relationships
  belongs_to  :binder
  has_many    :notes, :as => :notable, :dependent => :destroy
  has_many    :documents, :as => :documentable, :dependent => :destroy
  has_many    :images, :as => :imageable, :dependent => :destroy

  # validations
  validates_length_of     :apn,       :maximum => 100
  validates_presence_of   :country, :message => I18n.t(:value_required)
  validates_length_of     :country,   :is => 2
  validates_presence_of   :address1, :message => I18n.t(:value_required)
  validates_length_of     :address1,  :maximum => 50
  validates_length_of     :address2,  :maximum => 50
  validates_presence_of   :city, :message => I18n.t(:value_required)
  validates_length_of     :city,      :maximum => 50
  validates_presence_of   :state, :message => I18n.t(:value_required)
  validates_length_of     :state,     :maximum => 10
  #validates_presence_of  :zip, :message => I18n.t(:value_required)
  validates_length_of     :zip,       :maximum => 20
  validates_format_of     :county,    :with => /^[a-zA-Z]{0,50}$/,  :allow_blank => true
  validates_format_of     :acres,     :with => /^\d+\.?\d{0,2}$/,   :allow_blank => true
  
end
