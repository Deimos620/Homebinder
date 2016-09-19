class Note < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :notable, :polymorphic => true
  
  def get_notable
    self.notable_type.classify.constantize.find(self.notable_id)
  end
end
