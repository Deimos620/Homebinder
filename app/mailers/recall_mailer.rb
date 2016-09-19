class RecallMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  def notify_email(recallCheck, user)
    @recallCheck = recallCheck
    mail(to: user.email, subject: 'Homebinder.com Recall Notification')
  end
end
