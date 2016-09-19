class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :taggable, :polymorphic => true
  
  def get_tagable
     self.tagable_type.classify.constantize.find(self.tagable_id)
  end
end
