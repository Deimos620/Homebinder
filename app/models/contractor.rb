class Contractor < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many    :contractor_abilities
  has_many    :binder_contractors
  has_many    :binders, :through => :binder_contractors
  has_one     :address, :as => :addressable
  
  
  accepts_nested_attributes_for :address
  
  before_save { |c| c.name = c.name.downcase }
  
  phony_normalize :phone, :default_country_code => 'US'
  
  validates_presence_of     :name, :message => I18n.t(:value_required)
  validates_length_of       :name, :maximum => 100
  #validates_format_of       :phone,  :with => /\d{3}-\d{3}-\d{4}/, :message => "bad format, use xxx-xxx-xxxx", :allow_blank => true
  validates_plausible_phone :phone, :presence => false, :message => 'Invalid phone number'
  #validates_format_of       :email, :with => /^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/, :allow_blank => true
  validates_length_of       :url, :maximum => 250
  
  #scope :my_contractors, ->(binder_id, user_id) { Binder.joins(:contractors).merge(:verified_or_created_by).select('contractors.*').where(binders: { id: binder_id })}
  scope :verified_or_created_by, ->(user_id) { Contractor.where("contractors.verified = ? or contractors.created_by = ?", true, user_id).order("name") }
  
  after_create :add_new_typeahead_options
  
  def add_new_typeahead_options
    ContractorType.where(:name => self.contractor_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.contractor_type.nil?
  end
  
end
