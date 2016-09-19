class HomeownerMailer < ActionMailer::Base
  default :from => "donotreply@homebinder.com"
  
  def confirmation_email(homeowner)
    @homeowner = homeowner
    mail(:to => homeowner.email, :subject => "Welcome to HomeBinder")
  end
  
  def reset_password_email(homeowner)
    @homeowner = homeowner
    mail(:to => homewner.email, :subect => "HomeBinder Reset Password")
  end
end
