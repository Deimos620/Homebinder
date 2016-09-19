class HeatSource < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |h| h.name = h.name.downcase }
  
  def self.available(user_id)
    HeatSource.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
