class Api::V1::ApiController < HomebinderController

  rescue_from SubscriptionError, :with => :subscription_error
  
  protected
  
  def verify_subscription
    raise SubscriptionError unless @binder.subscription.plan_id == 'free' || @binder.subscription.payment_status == 'paid'
  end
  
  def subscription_error
    render :status => 402, :json => {:message => "The subscription for the binder has not been paid."}
  end
  
end