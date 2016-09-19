class Structure < ActiveRecord::Base
  resourcify
  
  #relationships
  belongs_to :property

  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  # validations
  validates_presence_of       :name, :message => I18n.t(:value_required)
  validates_length_of         :name, :maximum => 50
  validates_numericality_of   :year_built, :greater_than_or_equal_to => 1700, :less_than_or_equal_to => Date.today.year, :only_integer => true, :allow_nil => true
  validates_numericality_of   :sq_ft, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000000, :only_integer => true, :allow_nil => true
  validates_numericality_of   :beds, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 50, :only_integer => true, :allow_nil => true
  validates_numericality_of   :baths, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 50, :allow_nil => true
  
  after_create :add_new_typeahead_options
 
  def add_new_typeahead_options
    BuildingType.where(:name => self.building_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.building_type.nil?
    ConstructionStyle.where(:name => self.construction_style.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.construction_style.nil?
    ConstructionType.where(:name => self.construction_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.construction_type.nil?
    HeatType.where(:name => self.heat_type.downcase).first_or_create(:verified => false, :created_by => self.created_by).id unless self.heat_type.nil?
    HeatSource.where(:name => self.heat_source.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.heat_source.nil?
  end
  
end
