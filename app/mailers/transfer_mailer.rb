class TransferMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  def notify_email(transfer_to, transfer_by, binder)
    @transfer_to = transfer_to
    @transfer_by = transfer_by
    @binder = binder
    mail(to: @transfer_to, subject: 'Homebinder.com Transfer Notification')
  end
  
  def notify_unregistered_email(transfer_to, transfer_by, binder)
    @transfer_to = transfer_to
    @transfer_by = transfer_by
    @binder = binder
    mail(to: @transfer_to, subject: 'Homebinder.com Transfer Notification')
  end
end
