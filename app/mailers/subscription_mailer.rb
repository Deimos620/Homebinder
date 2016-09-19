class SubscriptionMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  def notify_subscribed(user, binder, data)
    @binder = binder
    @plan = data.object.plan
    mail(to: user.email, subject: 'Homebinder.com Subscription Notification')
  end
  
  def notify_subscription_canceled(user, binder, data)
    @binder = binder
    @plan = data.object.plan
    mail(to: user.email, subject: 'Homebinder.com Subscription Canceled Notification')
  end
  
  def notify_payment_succeeded(user, binder, data)
    @binder = binder
    @invoice = data.object
    mail(to: user.email, subject: 'Homebinder.com Payment Notification')
  end
  
  def notify_payment_failed(user, binder, data)
    @binder = binder
    @invoice = data.object
    mail(to: user.email, subject: 'Homebinder.com Payment Failed Notification')
  end
  
end