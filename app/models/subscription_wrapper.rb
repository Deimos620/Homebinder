require 'stripe'

class SubscriptionWrapper
  attr_reader :id
  attr_reader :binder
  attr_reader :plan
  attr_reader :payment_status
  attr_reader :card_type
  attr_reader :last4
  attr_reader :subtotal
  attr_reader :discount
  attr_reader :end_date
  
  def initialize(binder)
    subscription = binder.subscription
    @binder = binder
    @id = subscription.id
    @plan = subscription.plan_id
    @payment_status = subscription.payment_status
    # if there's no cutomer ID don't bother with stripe
    if subscription.customer_id.nil?
      return
    end

    customer = Stripe::Customer.retrieve(subscription.customer_id)
    # if we weren't able to get a customer from stripe exit.
    # this is bad we're out of sync
    if customer.nil?
      return
    end
    
    # if the customer has a default card get info
    if not customer.default_card.nil?
      card = customer.cards.retrieve(customer.default_card)
      @card_type = card.type
      @last4 = card.last4
    end
      
    # get some plan and discount info
    @subtotal = customer.subscription.plan.amount
    @discount = 0.00
    if not customer.discount.nil?
      @discount = customer.discount.coupon.amount_off.nil? ?
        @subtotal * (customer.discount.coupon.percent_off / 100.00) 
          : customer.discount.coupon.amount_off
    end 
    @end_date = customer.subscription.current_period_end
  end
end