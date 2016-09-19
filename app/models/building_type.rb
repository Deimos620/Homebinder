class BuildingType < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |b| b.name = b.name.downcase }
  
  def self.available(user_id)
    BuildingType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
