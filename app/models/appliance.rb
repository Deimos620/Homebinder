class Appliance < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder

  has_one :purchase, :as => :purchaseable
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
  validates_length_of :serial_no, :maximum => 50
  validates_length_of :warranty, :maximum => 250
  validates_length_of :user_guide_url, :maximum => 120
  validates_format_of :upc, :with => /\A[0-9]{12}\Z/, :allow_blank => true, :allow_nil => true
  
  accepts_nested_attributes_for :purchase
  
  after_create :add_new_typeahead_options
 
  def add_new_typeahead_options
    ApplianceType.where(:name => self.appliance_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.appliance_type.nil?
    ApplianceManufacturer.where(:name => self.manufacturer.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.manufacturer.nil?
    ApplianceModel.where(:name => self.model).first_or_create(:verified => false, :created_by => self.created_by) unless self.model.nil?
  end
  
  def self.weekly_recall_check
    appliances = Appliance.all
    appliances.each do |a|
      
      binder = Binder.includes(:subscription).find(a.binder_id)
      if binder.subscription.plan_id == 'free'
        next
      end
      
      if a.last_recall_check.nil? or
        Date.current - a.last_recall_check > 30
          recallCheck = RecallCheck.new(a)
          recallCheck.run(a.last_recall_check, 1)
          if recallCheck.total > 0
            binder = Binder.find(a.binder_id)
            user = binder.get_owner
            RecallMailer.delay.notify_email(recallCheck, user)
          end
      end
    end
  end
  
  def has_upc
    not self.upc.nil? and not self.upc.empty?
  end
  
  def has_manufacturer_and_model
    not self.manufacturer.nil? and
    not self.manufacturer.empty? and
    not self.model.nil? and
    not self.model.empty?
  end
  
  def ready_for_recall
    self.has_upc or self.has_manufacturer_and_model
  end
  
end
