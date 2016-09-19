class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :token_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         #:confirmable,
         :omniauthable,
         :async
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # attr_accessible :title, :body
  attr_accessor :role
  
  # associations
  has_one :user_profile
  has_and_belongs_to_many :binders
  
  # callbacks
  after_create :create_profile
  before_destroy :cleanup
  
  # Free Trial Stuff
  def eligible_for_free_trial
    self.created_at >= Time.now.months_ago(3)
  end
  
  def free_trial_remaining
    Time.now - self.created_at
  end
  
  # monthly email
  def self.monthly_email
    
    require 'date'
    
    today       = Date.today
    email_date  = Date.new(today.year, today.month, 1)
    
    # only send the email on the first of the month
    if today == email_date
      users = User.all
      users.each do |u|
        email_user = User.find(u.id)
        
        # only send the email if they are subscribed
        if email_user.user_profile.monthly_email
          email_user_binders  = u.binders
        
          MonthlyEmailMailer.delay.notify_email(email_user, email_user_binders)
        end
      end
    else
      puts "not the first of month... no emails sent..."      
    end
         
  end
  
  def global_role
    if self.has_role? :admin
      return 'admin'
    end
    if self.has_role? :partner_admin
      return 'partner_admin'
    end
    if self.has_role? :broker
      return 'broker'
    end
    return 'user'
  end
  
 private
 
  def create_profile
    @profile = self.build_user_profile(user_id: self.id)
    @profile.build_address
    @profile.save
    
    if (self.email.downcase == "dev@homebinder.com" ||
        self.email.downcase == "jim@homebinder.com" ||
        self.email.downcase == "jon@homebinder.com" ||
        self.email.downcase == "guy@homebinder.com" ||
        self.email.downcase == "jack@homebinder.com")
       self.add_role :admin
     end
  end
  
  def cleanup
    # delete any shares related to the user
    Share.delete_shared_by self.id
    Share.delete_shared_with self.id
    
    # delete the users binders
    self.binders.each do |b|
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      puts self.has_role? :owner, b
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      if self.has_role? :owner, b
        # delete the binder
        b.destroy
      end
    end
  end
  
end
