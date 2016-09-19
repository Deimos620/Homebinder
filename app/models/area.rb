class Area < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder
  
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy

  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
  
  after_create :add_new_typeahead_options
  
  def add_new_typeahead_options
    AreaType.where(:name => self.area_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.area_type.nil?
  end
  
  def structures
    return TagManager.find_tagged_resources(self.tags)[:structures]
  end
  
end
