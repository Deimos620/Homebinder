class FreeTrialRequestMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  def notify_free_trial_request_mail(free_trial)
    @free_trial = free_trial
    mail(to: "support@homebinder.com", subject: "Request free trial")
  end
end
