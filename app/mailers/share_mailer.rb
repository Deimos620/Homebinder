class ShareMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  def notify_email(share)
    @share = share
    @shared_by = User.find(share.shared_by_id)
    @sharable = share.get_sharable
    mail(to: @share.shared_with_email, subject: 'Homebinder.com Share Notification')
  end
  
end
