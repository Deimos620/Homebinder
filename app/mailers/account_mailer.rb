class AccountMailer < ActionMailer::Base
  default :from => "donotreply@homebinder.com"
  
  def verification_email(account)
    @account = account
    mail(:to => account.email, :subect => "Welcome to HomeBinder")
  end
  
  def reset_password_email(account)
    @account = account
    mail(:to => account.email, :subect => "HomeBinder Reset Password")
  end
end
