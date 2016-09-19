class MaintenanceEvent < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :maintenance_item

  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy

end
