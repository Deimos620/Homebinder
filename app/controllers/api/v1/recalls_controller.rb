class Api::V1::RecallsController < Api::V1::ApiController
  
  def index
    @appliance = Appliance.find(params[:appliance_id])
    @page = params[:page].nil? ? 0 : params[:page]
    
    binder = Binder.includes(:subscription).find(@appliance.binder_id)
    if binder.subscription.plan_id == 'free'
      raise 'Permission Denied'
    end
    
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @recallCheck = RecallCheck.new(@appliance)
    @recallCheck.run(nil, @page)
  end
  
end
