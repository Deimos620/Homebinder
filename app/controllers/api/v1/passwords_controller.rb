class Api::V1::PasswordsController < Api::V1::ApiController
  skip_before_filter :verify_jwt_token
  
  def create
    @user = User.find_by_email(params[:user][:email])
    render status: :not_found, json: { message: 'No user with the specified email found.' } unless not @user.nil?
    User.send_reset_password_instructions(params[:user])
    head :no_content
  end
  
  def update
    @user = User.reset_password_by_token(params[:user])
    if @user.errors.empty?
      @user.ensure_authentication_token!
      @token = create_jwt_token(
      {
        email: @user.email,
        user_token: @user.authentication_token,
        user_role: @user.global_role
      })
      
      render :status=>200, :json=>@token
    else
      render status :unprocessable_entity, json: @user.errors
    end
  end
  
end