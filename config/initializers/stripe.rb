# config/initializers/stripe.rb
#Stripe.api_key = ENV['STRIPE_API_KEY'] # Set your api key
Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.setup do

  subscribe 'invoice.payment_succeeded' do |event|
    if event.data.object.total == 0
      return
    end
    
    SubscriptionService.notify_payment_succeeded(event)
  end
  
  subscribe 'invoice.payment_failed' do |event|
    if event.data.object.total == 0
      return
    end
    
    SubscriptionService.notify_payment_failed(event)
  end
  
  #subscribe 'customer.subscription.created' do |event|
  #  subscription = Subscription.find_by_customer_id(event.data.object.customer)
  #  if not subscription.nil?
  #    subscription.notify_subscribed(event)
  #  end
  #end
  
  subscribe 'customer.subscription.deleted' do |event|
    if event.data.object.total == 0
      return
    end
    
    SubscriptionService.notify_subscription_canceled(event)
  end
  
end