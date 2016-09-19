class MonthlyEmailMailer < ActionMailer::Base
  default from: "donotreply@homebinder.com"
  
  require 'date'
  require 'active_support'
  require 'active_support/core_ext'
  
  def notify_email(user, binders)
    @email_user     = user
    @email_binders  = binders
    @date           = Date.today
    @dateplus2mo    = @date + 2.months
    
    sbjct = "Your HomeBinder Update for #{@date.strftime("%B")} #{@date.strftime("%Y")}"
        
    mail(to: @email_user.email, subject: sbjct)
  end

end
