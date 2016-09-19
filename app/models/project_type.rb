class ProjectType < ActiveRecord::Base
  # attr_accessible :title, :body
    before_save { |p| p.name = p.name.downcase }
  
  def self.available(user_id)
    ProjectType.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |type| type.name.titleize }
  end
end
