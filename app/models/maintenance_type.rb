class MaintenanceType < ActiveRecord::Base
  # attr_accessible :title, :body
  
  before_save { |m| m.name = m.name.downcase }
  
  def self.available(user_id)
    MaintenanceType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
  
end
