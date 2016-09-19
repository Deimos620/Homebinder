class Receipt < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder
  
  has_one :purchase, :as => :purchaseable
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  accepts_nested_attributes_for :purchase
  
  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
end
