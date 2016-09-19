class Transfer < ActiveRecord::Base
  # attr_accessible :title, :body
  
  validates_presence_of :user_id
  validates_presence_of :binder_id
  validates_presence_of :transfer_to
  validates_presence_of :transfer_type

  
end