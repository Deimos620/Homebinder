class Pdf < ActiveRecord::Base
  #relationships
  belongs_to :pdfable, :polymorphic => :true
  
  def get_pdfable
    self.pdfable_type.classify.constantize.find(self.pdfable_id)
  end
end
