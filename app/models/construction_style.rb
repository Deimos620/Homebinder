class ConstructionStyle < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |c| c.name = c.name.downcase }
  
  def self.available(user_id)
    ConstructionStyle.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |style| style.name.titleize }
  end
end
