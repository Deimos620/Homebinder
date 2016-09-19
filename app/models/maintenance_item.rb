class MaintenanceItem < ActiveRecord::Base
  # attr_accessible :title, :body
  resourcify
  
  belongs_to :binder
  
  has_many :maintenance_events, :dependent => :destroy
  has_many :shares, :as => :sharable
  has_many :notes, :as => :notable
  has_many :tags, :as => :taggable, :dependent => :destroy
  
  validates_presence_of :name, :message => I18n.t(:value_required)
  validates_length_of :name, :maximum => 50
  validates_length_of :details, :maximum => 500
  validates_numericality_of :interval, :greater_than_or_equal_to => 1, :allow_blank => true
  
  #before_create { |item| item.due_on = item.start_on }
  after_save :update_do_date
  
  after_create :add_new_typeahead_options
  
  def add_new_typeahead_options
    MaintenanceType.where(:name => self.maintenance_type.downcase).first_or_create(:verified => false, :created_by => self.created_by) unless self.maintenance_type.nil?
  end
  
  def do_date
    if self.maintenance_events.count == 0
      dt = Date.current
      dt = dt.advance(:years => 1)
      return dt
    else
      self.maintenance_events.where(:completed_date => nil).first.do_date
    end
  end
  
  def do_date=(date)
    @do_date = date
  end
  
  def update_do_date
    if @do_date.nil?
      return
    end
    
    if self.maintenance_events.count == 0
      evt = MaintenanceEvent.new(maintenance_item_id: self.id, created_by: self.created_by, do_date: @do_date)
      evt.save
    else
      evt = self.maintenance_events.where(:completed_date => nil).first
      evt.do_date = @do_date
      evt.save
    end
  end
  
  def next_event_date(from_date)
    cycle = self.maintenance_cycle
    if cycle.nil?
      return
    end
    
    d = from_date
    if from_date.nil? 
      d = Date.today
    end
    
    d = d.advance(:days => self.interval) if cycle == "Days"
    d = d.advance(:weeks => self.interval) if cycle == "Weeks"
    d = d.advance(:months => self.interval) if cycle == "Months"
    d = d.advance(:years => self.interval) if cycle == "Years"
    return d
  end
  
  def schedule_next_event
    # Only schedule a next event if there already isn't a pending event
    if self.maintenance_events.where(:completed_date => nil).count == 0
      evt = MaintenanceEvent.new(maintenance_item_id: self.id, created_by: self.created_by, do_date: next_event_date(last_event.completed_date))
      evt.save
    end
  end
  
  def next_event
    self.maintenance_events.where(:completed_date => nil).first
  end
  
  def last_event
    self.maintenance_events.where("completed_date IS NOT NULL").order("completed_date DESC").first
  end
  
  def get_next_event_date
    evt = self.maintenance_events.where(:completed_date => nil).first
    return evt.nil? ? nil : evt.do_date
  end
  
  def get_last_completed_date
    evt = self.maintenance_events.where("completed_date IS NOT NULL").order("completed_date DESC").first
    return evt.nil? ? nil : evt.completed_date
  end
  
end
