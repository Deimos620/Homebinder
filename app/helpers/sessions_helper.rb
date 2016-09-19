module SessionsHelper
  
#  def sign_in(account, remember)
#    session[:account_id] = @account.id
#    if (remember)   
#      cookies[:remember_me] = { value: @account.remember_key, expires: 14.days.from_now.utc }
#    end
#  end
  
#  def signed_in?
#    !current_account.nil?
#  end
  
#  def current_account=(account)
#    @current_account = account
#  end
  
#  def current_account
#    if (!session[:account_id].nil?)
#      @current_account || Account.find_by_id(session[:account_id])
#    else 
#      if (!cookies[:remember_key].nil?)
#        @current_account || Account.find_by_remember_key(cookies[:remember_key])
#      else
#        nil
#      end
#    end
#  end
  
#  def sign_out
#    session[:account_id] = nil
#    cookies[:remember_key] = nil
#  end
  
end
