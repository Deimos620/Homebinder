class ApplianceManufacturer < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |a| a.name = a.name.downcase }
  
  def self.available(user_id)
    ApplianceManufacturer.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |app| app.name.titleize }
  end
end
