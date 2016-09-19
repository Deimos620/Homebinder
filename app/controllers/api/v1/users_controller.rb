class Api::V1::UsersController < Api::V1::ApiController
  
  skip_before_filter :verify_jwt_token, :only => [:show]
  
  def show
    @user = User.find_by_authentication_token(params[:id])
    @ability = Ability.new(@user)
  end
  
end