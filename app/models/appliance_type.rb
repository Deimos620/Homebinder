class ApplianceType < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |a| a.name = a.name.downcase }
  
  def self.available(user_id)
    ApplianceType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
