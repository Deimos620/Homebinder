class Partner < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :address, :as => :addressable, :dependent => :destroy
  has_many :logos, :dependent => :destroy
  has_many :promo_codes
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  accepts_nested_attributes_for :address
  
  phony_normalize :phone, :default_country_code => 'US'
  
  before_save {|partner| partner.code = partner.code.upcase}
  
  validates_presence_of   :name
  validates_presence_of   :code
  validates_uniqueness_of :code
  validates_presence_of   :partner_type
  
  def binder_logo
    self.binder_logo_id.nil? ? nil : Logo.find(self.binder_logo_id)
  end
  
  def seller_report_logo
    self.sellers_logo_id.nil? ? nil : Logo.find(self.sellers_logo_id)
  end
  
end
