class BinderContractor < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder
  belongs_to :contractor
  
  has_many    :shares, :as => :sharable
  has_many    :notes, :as => :notable
  has_many    :tags, :as => :taggable, :dependent => :destroy
  
  accepts_nested_attributes_for :contractor
  
  before_destroy :destroy_contractor
  
  def name
    self.contractor.name
  end
  
  private
  
  def destroy_contractor
    if self.contractor.verified == false
      self.contractor.destroy
    end
  end
  
end
