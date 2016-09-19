class Api::V1::UserTokensController < Api::V1::ApiController
  
  skip_before_filter :verify_jwt_token, :only => [:create]

  def create
    email = params[:email]
    password = params[:password]
 
    if email.nil?
       render :status=>400, :json=>{:message=>"The request must contain the user email and password."}
       return
    end
 
    @user=User.find_by_email(email.downcase)
 
    if @user.nil?
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end
 
    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
    @user.ensure_authentication_token!
    @ability = Ability.new(@user)
 
    if not @user.valid_password?(password)
      render :status=>401, :json=>{:message=>"Invalid email or password."}
      return
    end
    
    @user.sign_in_count += 1
    @user.last_sign_in_at = DateTime.now
    @user.save
    
    @token = create_jwt_token(
    {
      email: @user.email,
      user_token: @user.authentication_token,
      user_role: @user.global_role
    })
    
    render :status=>200, :json=>@token
  end
 
  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end
end
