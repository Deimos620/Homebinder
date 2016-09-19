class InventoryItemType < ActiveRecord::Base
  # attr_accessible :title, :body
  
  before_save { |i| i.name = i.name.downcase }
  
  def self.available(user_id)
    InventoryItemType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
