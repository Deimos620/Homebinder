class FreeTrial < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :name
  validates_length_of   :name,        :maximum => 50
  validates_presence_of :email
  validates_length_of   :email,       :maximum => 50
  validates_presence_of :partner_type
  validates_presence_of :trial_type
  validates_presence_of :status
end
