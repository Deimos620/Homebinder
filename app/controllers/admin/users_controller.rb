class Admin::UsersController < Admin::AdminController
  
  def index
    @users = User.includes(:user_profile).all
  end
  
  def destroy
    @delete_user = User.find(params[:id])
    @delete_user.destroy unless not @delete_user
    head :no_content
  end
  
end