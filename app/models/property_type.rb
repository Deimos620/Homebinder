class PropertyType < ActiveRecord::Base
  #before_save { |p| p.name = p.name.downcase }
  
  def self.available(user_id)
    PropertyType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.humanize }
  end
end
