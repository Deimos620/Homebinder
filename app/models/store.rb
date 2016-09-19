class Store < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |s| s.name = s.name.downcase }
  
  def self.available(user_id)
    Store.where("verified = ? OR created_by = ?", true, user_id)
  end
end
