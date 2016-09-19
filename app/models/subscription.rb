class Subscription < ActiveRecord::Base
  require "stripe"

  belongs_to :binder
  
  #before_save :save_to_stripe
  before_destroy :clean_stripe
  
  #attr_accessor :stripe_token
  #attr_accessor :coupon_id
  #attr_accessor :action
=begin  
  def notify_subscription_canceled(e)
    binder = Binder.find(self.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_subscription_canceled(user, binder, e.data)
    # we need to check if the subscription was canceled by stripe due to failed payments
    # if it was then update our database
    cust = Stripe::Customer.retrieve(self.customer_id)
    if not cust.deleted
      cust.delete
      self.plan_id = 'free'
      self.customer_id = nil
      self.payment_status = nil
      self.save
    end
    
  end
  
  def notify_payment_succeeded(e)
    binder = Binder.find(self.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_payment_succeeded(user, binder, e.data)
    self.payment_status = "paid"
    self.save
  end
  
  def notify_payment_failed(e)
    binder = Binder.find(self.binder_id)
    user = binder.get_owner
    SubscriptionMailer.delay.notify_payment_failed(user, binder, e.data)
    self.payment_status = 'failed'
    self.save
  end
  
  def cancel
    if not self.customer_id.nil?
      cancel_subscription
      self.save
    end
  end
=end
  
  private
  
  def save_to_stripe
    case self.action
    when 'upgrade'
      subscribe_to_plan
    when 'update'
      update_payment_method
    when 'cancel'
      cancel_subscription
    end
  end
  
  def clean_stripe
    if not self.customer_id.nil?
      cust = Stripe::Customer.retrieve(self.customer_id)
      cust.delete
    end
  end
  
  def cancel_subscription
    return unless not self.customer_id.nil?
    cust = Stripe::Customer.retrieve(self.customer_id)
    if not cust.nil?
      cust.cancel_subscription
      cust.delete
    end
    
    self.plan_id = 'free'
    self.customer_id = nil
    self.payment_status = nil
  end
  
  def subscribe_to_plan
    cust = Stripe::Customer.create(:description =>  "Binder #{self.binder_id}")
    cust.plan = self.plan_id
    cust.card = self.stripe_token unless self.stripe_token.nil? or self.stripe_token.empty?
    cust.coupon = self.coupon_id unless self.coupon_id.nil? || self.coupon_id.empty?
    cust.save
    
    self.customer_id = cust.id
    self.payment_status = 'paid'
  end
  
  def update_payment_method
    customer = Stripe::Customer.retrieve(self.customer_id)
    if not customer.default_card.nil?
      delete_card = customer.cards.retrieve(customer.default_card)
      delete_card.delete
    end
    
    customer.cards.create(:card => self.stripe_token)
    customer.save
    
    # if the user has a failed payment we will try this new card
    if self.payment_status == 'failed'
      Stripe::Invoice.all(:customer => self.customer_id).each do |invoice|
        if invoice.paid == false
          invoice.pay
          break
        end
      end
    end
  end
   
end
