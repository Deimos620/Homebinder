class ContractorAbility < ActiveRecord::Base
  # attr_accessible :title, :body
  before_save { |c| c.name = c.name.downcase }
  
  def self.available(user_id)
    ContractorAbility.where("verified = ? OR created_by = ?", true, user_id).order("name").map { |con| con.name.titleize }
  end
end
