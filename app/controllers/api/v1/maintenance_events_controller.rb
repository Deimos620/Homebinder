class Api::V1::MaintenanceEventsController < Api::V1::ApiController  
  before_filter :load_binder, :only => [:index, :show]
  
  def index
    # check if the user can read the binder
    @ability.authorize! :read, @binder
    
    # verify the subscription
    verify_subscription
    
    # get the maintenance events
    @maintenance_events = MaintenanceEvent.where(:maintenance_item_id => params[:maintenance_item_id]).order("do_date DESC")
  end

  def show
    # get the maintenance event
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    render status: :not_found, json: { :message => "Maintenance event not found" } unless not @maintenance_event.nil?
    
    # check if the user can read it
    @ability.authorize! :read, @maintenance_event
    
    # verify the subscription
    verify_subscription
  end

  def create
    # load the event
    @maintenance_event = MaintenanceEvent.new(params[:maintenance_event])
    
    # check if the user can create in the binder
    mi = MaintenanceItem.find(@maintenance_event.maintenance_item_id)
    binder = Binder.find(mi.binder_id)
    
    @ability.authorize! :create, binder
    
    # save the event
    if not @maintenance_event.save
      render status: :unprocessable_entity, json: @maintenance_event.errors
    end
  end

  def update
    # load the event
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    render status: :not_found, json: { :message => "Maintenance event not found" } unless not @maintenance_event.nil?
    
    # check if the user can write to the event
    @ability.authorize! :write, @maintenance_event

    # save the event
    if @maintenance_event.update_attributes(params[:maintenance_event])
      if (@maintenance_event.completed_date)
        mi = MaintenanceItem.find(@maintenance_event.maintenance_item_id)
        mi.schedule_next_event
      end
    else
      render status: :unprocessable_entity, json: @maintenance_event.errors
    end
  end

  def destroy
    # load the event
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    # check if the user can destroy the event
    @ability.authorize! :destroy, @maintenance_event
    
    # destroy the event
    @maintenance_event.destroy

    head :no_content
  end
  
private
  def load_binder
    mi = MaintenanceItem.find(params[:maintenance_item_id]) 
    @binder = Binder.find(mi.binder_id)
  end

end
