class FinishModel < ActiveRecord::Base
  # attr_accessible :title, :body
    before_save { |f| f.name = f.name.downcase }
  
  def self.available(user_id)
    FinishModel.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |fin| fin.name.titleize }
  end
end
