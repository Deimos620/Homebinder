class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to  :binder

  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  validates_presence_of   :name, :message => I18n.t(:value_required)
  validates_length_of     :name, :maximum => 50
  
  monetize  :cost_cents, :allow_nil => true
  
  after_create :add_new_typeahead_options
 
  def add_new_typeahead_options
    ProjectType.where(:name => self.project_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.project_type.nil?
  end
  
  def get_status
    ProjectStatus.find(self.project_status_id).name unless self.project_status_id.nil?
  end
  
end
