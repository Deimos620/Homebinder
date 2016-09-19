class Share < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :sharable, :polymorphic => true
  
  validates_presence_of :shared_with_email
  validates_presence_of :role_name
  
  after_create :notify_of_share
  after_save :apply_role
  
  scope :with_user, ->(email) { where("shared_with_email = ? AND status = ?", email, 'pending') }
  
  def self.pending_share_count(user_email)
    Share.where("shared_with_email = ? AND status = ?", user_email, "pending").count
  end
   
  def check_for_existing_role?
    if self.status == 'accepted' || self.status == 'rejected'
      return true
    end
    
    self.shared_with_email = self.shared_with_email.downcase
    sharable = self.sharable_type.classify.constantize.find(self.sharable_id)
    user = User.find_by_email(self.shared_with_email)
   
    return Share.where(
                :shared_with_email => self.shared_with_email,
                :sharable_type => self.sharable_type,
                :sharable_id => self.sharable_id).count > 0
  end
  
  def accept
    if self.status != 'pending'
      return
    end
    
    user = User.find_by_email(self.shared_with_email)
    
    if user
      self.shared_with_id = user.id
      self.status = 'accepted'
      
      if self.sharable_type == 'binder'
        user.binders << self.get_sharable
      end
    end
  end
  
  def stop
     if self.shared_with_id
      user = User.find(self.shared_with_id)
      user.remove_role self.role_name, self.sharable_type.classify.constantize.find(self.sharable_id)
      
      if self.sharable_type.downcase == 'binder'
        user.binders.delete(self.get_sharable)
      end
    end
  end
  
  def notify_of_share
    ShareMailer.delay.notify_email(self)
  end
  
  def apply_role
    if self.status != 'accepted'
      return
    end
    
    sharable = self.sharable_type.classify.constantize.find(self.sharable_id)
    user = User.find(self.shared_with_id)
    user.add_role self.role_name, sharable
    if sharable.class.name.downcase == 'binder'
      user.binders << sharable
    end
  end
  
  def self.delete_shared_by(user_id)
    shares = Share.where(:shared_by_id => user_id)
    shares.each do |s|
      s.destroy
    end
  end
  
  def self.delete_shared_with(user_id)
    shares = Share.where(:shared_with_id => user_id)
    shares.each do |s|
      s.destroy
    end
  end
  
  def get_sharable
    self.sharable_type.classify.constantize.find(self.sharable_id)
  end
  
  def get_shared_by_email
    User.find(self.shared_by_id).email
  end
  
  def get_shared_name
    self.get_sharable.name
  end
  
end
