class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :purchaseable, :polymorphic => true
  
  monetize :price_cents, :allow_nil => true
  
  def store
    Store.find(self.store_id).name.titleize unless self.store_id.nil?
  end
  
  def store=(str)
    self.store_id = Store.where(:name => str.downcase).first_or_create(:verified => false, :created_by => self.created_by).id unless str.nil?
  end
end
