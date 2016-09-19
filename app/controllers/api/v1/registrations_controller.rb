class Api::V1::RegistrationsController < Api::V1::ApiController
  skip_before_filter :verify_jwt_token
  
  def create
    @user = User.new(params[:user])
    if not @user.save
      warden.custom_failure!
      render status: :unprocessable_entity, json: @user.errors
      return
    end
    @user.ensure_authentication_token!
    @ability = Ability.new(@user)
    
    # check for any pending transfers to the user
    transfers = Transfer.where(transfer_to: @user.email.downcase, status: 'pending')
    transfers.each do |t|
      service = TransferService.new(@user, t)
      service.resume_transfer
    end
    
    # provide the desired next step
    @token = create_jwt_token(
    {
      email: @user.email,
      user_token: @user.authentication_token,
      user_role: @user.global_role
    })
    
    render :status=>200, :json=>@token
  end
  
  def show
    @user = User.confirm_by_token(params[:confirmation_token])
    if not @user.errors.empty?
      warden.custom_failure!
      render status: :unprocessable_entity, json: @user.errors
    else
      @user.ensure_authentication_token!
      @ability = Ability.new(@user)
    end
  end
  
end