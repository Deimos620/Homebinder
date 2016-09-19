class HeatType < ActiveRecord::Base
  before_save { |h| h.name = h.name.downcase }
  
  def self.available(user_id)
    HeatType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
