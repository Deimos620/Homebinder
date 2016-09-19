module SubscriptionVerify
  def not_expired!(binder_id)
    subscription = Subscription.find_by_binder_id(binder_id)
 
    if subscription.nil?
      # no subscription means free
      return
    end
    
    # check if the user is deliquent
    c = Stripe::Customer.retrieve(subscription.customer_id)
    if c.delinquent
      raise SubscriptionException, "Subscription has expired"
    end
  end
end

class SubscriptionException < StandardError
end