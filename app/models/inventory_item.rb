class InventoryItem < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to  :binder
  
  monetize :value_cents, :allow_nil => true
  
  validates_presence_of   :name
  validates_length_of     :name, :maximum => 50
  
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  after_create :add_new_typeahead_options
  
  def add_new_typeahead_options
    InventoryItemType.where(:name => self.inventory_item_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.inventory_item_type.nil?
  end
  
end
