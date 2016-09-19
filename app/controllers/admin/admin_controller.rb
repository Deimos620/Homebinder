class Admin::AdminController < HomebinderController

  before_filter :verify_user_is_admin
  
  protected

  def verify_user_is_admin
    permission_denied unless @current_user.has_role?(:admin)
  end
  
end