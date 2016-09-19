require 'stripe'

class SubscriptionService
  
  def self.update_subscription(action, subscription, card, coupon)
    case action
      when 'upgrade'
        upgrade(subscription, card, coupon)
      when 'update'
        update_card(subscription, card)
      when 'cancel'
        cancel(subscription)
    end
  end
  
  def notify_subscription_canceled(e)
    # get the subscripton the event is for
    subscription = Subscription.find_by_customer_id(e.data.object.customer)
    return unless not subscription.nil?
    # send an email
    binder = Binder.find(subscription.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_subscription_canceled(user, binder, e.data)
    # we need to check if the subscription was canceled by stripe due to failed payments
    # if it was then update our database
    cust = Stripe::Customer.retrieve(subscription.customer_id)
    if not cust.deleted
      cust.delete
      subscription.plan_id = 'free'
      subscription.customer_id = nil
      subscription.payment_status = nil
      subscription.save
    end
    
  end
  
  def notify_payment_succeeded(e)
    # get the subscripton the event is for
    subscription = Subscription.find_by_customer_id(e.data.object.customer)
    return unless not subscription.nil?
    # send an email
    binder = Binder.find(subscription.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_payment_succeeded(user, binder, e.data)
    # update our status
    subscription.payment_status = "paid"
    subscription.save
  end
  
  def notify_payment_failed(e)
    # get the subscripton the event is for
    subscription = Subscription.find_by_customer_id(e.data.object.customer)
    return unless not subscription.nil?
    # send an email
    binder = Binder.find(subscription.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_payment_failed(user, binder, e.data)
    # update our status
    subscription.payment_status = 'failed'
    subscription.save
  end
  
  private
  
  def self.upgrade(subscription, card, coupon)
    # upgrade the plan
    subscription.plan_id = 'standard'
     
    # check if a credit card is required for the request
    card_required = is_card_required?(coupon, 'standard')

    # create a card token
    if card_required and (card.nil? or card.empty?)
      raise CardRequiredException, 'A credit card is required'
    end
    
    # if credit card is required create a token
    if card_required
      card_token = create_card_token(card)
    end
    
    # create the customer in stripe
    cust = Stripe::Customer.create(:description =>  "Binder #{subscription.binder_id}")
    cust.plan = subscription.plan_id
    cust.card = card_token.id unless card_token.nil?
    cust.coupon = coupon unless coupon.nil? or coupon.empty?
    cust.save
    
    # store the stripe customer id and mark the subscription as paid
    subscription.customer_id = cust.id
    subscription.payment_status = 'paid'
    if not subscription.save
      raise UnprocessableException
    end
  end
  
  def self.update_card(subscription, card)
    if card.nil? or card.empty?
      raise CardRequiredException, 'A credit card is required'
    end
    
    # get the token for the card
    card_token = create_card_token(card)
    # get the customer
    customer = Stripe::Customer.retrieve(subscription.customer_id)
    # delete the current default card
    if not customer.default_card.nil?
      delete_card = customer.cards.retrieve(customer.default_card)
      delete_card.delete
    end
    # create the new card for the customer
    customer.cards.create(:card => card_token.id)
    customer.save
    # if the user has a failed payment we will try this new card
    if subscription.payment_status == 'failed'
      Stripe::Invoice.all(:customer => subscription.customer_id).each do |invoice|
        if invoice.paid == false
          invoice.pay
          break
        end
      end
    end
  end
  
  def self.cancel(subscription)
    # if there is no customer id nothing to cancel
    return unless not subscription.customer_id.nil?
    # get the customer from stripe and delete it
    cust = Stripe::Customer.retrieve(subscription.customer_id)
    if not cust.nil?
      cust.cancel_subscription
      cust.delete
    end
    # update our subscription
    subscription.plan_id = 'free'
    subscription.customer_id = nil
    subscription.payment_status = nil
    if not subscription.save
      UnprocessableException
    end
  end
  
  private
  
  def self.create_card_token(card)
    card_token = Stripe::Token.create(
        :card => {
          :number => card[:number],
          :exp_month => card[:exp_month],
          :exp_year => card[:exp_year],
          :cvc => card[:cvc]
        })
    
    return card_token
  end
  
  def self.is_card_required?(coupon, plan)
    # if there is no coupon we need a card
    return true if coupon.nil? or coupon.empty?
    
    pln = Stripe::Plan.retrieve(plan)
    cpn = Stripe::Coupon.retrieve(coupon)
    
    puts 'KKKKKKKKKKKKKKKKKKKK'
    puts pln.amount
    puts cpn.amount_off
    puts cpn.percent_off
    
    # Check if the amount off is the same as the plan amount
    if cpn.amount_off == pln.amount
      return false
    end
    
    # check if the percent off is 100
    if cpn.percent_off == 100
      return false
    end
    
    return true
  end

end