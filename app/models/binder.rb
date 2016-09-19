class Binder < ActiveRecord::Base
  require 'stripe'
  require 'securerandom'
  resourcify
  
  # relationships
  has_and_belongs_to_many :users
  has_one :subscription, :dependent => :destroy
  has_one :property, :dependent => :destroy
  has_one :seller_report, :dependent => :destroy
  
  has_many :structures, :dependent => :destroy
  has_many :areas, :dependent => :destroy
  has_many :appliances, :dependent => :destroy
  has_many :finishes, :dependent => :destroy
  has_many :paints, :dependent => :destroy
  has_many :binder_contractors, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_many :maintenance_items, :dependent => :destroy
  has_many :inventory_items, :dependent => :destroy
  has_many :receipts, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :shares,     :as => :sharable, :dependent => :destroy
  has_many :notes,      :as => :notable, :dependent => :destroy
  has_many :tags,       :as => :taggable, :dependent => :destroy
  has_many :pdfs,       :as => :pdfable, :dependent => :destroy
  
  # validations
  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
  
  accepts_nested_attributes_for :property
  accepts_nested_attributes_for :subscription
  
  before_destroy :cleanup
  
  def get_subscription_detail
    if self.subscription.customer_id.nil?
      return
    end
    
    customer = Stripe::Customer.retrieve(self.subscription.customer_id)
    @subscription = customer.subscription
  end
  
  def get_owner
    users = User.joins(:binders).where(binders: {id: self.id})
    users.each do |u|
      if u.has_role?(:owner, self)
        return u
      end
    end
    return nil
  end
  
  def partner
    partners = self.tags.where(["tag LIKE :tag", {:tag => 'partner_%'}])
    if (partners.length > 0)
      parts = partners[0].tag.split('_')
      return partner = Partner.find(parts[1])
    end
  end
  
  private
  
  def cleanup
    # remove the binder from any users with access
    users = User.joins(:binders).where(binders: {id: self.id})
    users.each do |u|
      # remove the role the user has
      if u.has_role? :owner, self
        u.remove_role :owner, self
      else if u.has_role? :co_owner, self
        u.remove_role :co_owner, self
      else if u.has_role? :reader, self
        u.remove_role :reader, self
      else if u.has_role? :reader_writer, self
         u.remove_role :reader_writer, self
      else if u.has_role? :partner_admin, self
        u.remove_role :partner_admin, self
      else if u.has_role? :broker, self
        u.remove_role :broker, self
      end
      end
      end
      end
      end
      end
      # remove the binder from the user's list
      u.binders.delete(self)
    end
    
  end
end
