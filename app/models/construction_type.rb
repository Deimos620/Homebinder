class ConstructionType < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |c| c.name = c.name.downcase }
  
  def self.available(user_id)
    ConstructionType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
