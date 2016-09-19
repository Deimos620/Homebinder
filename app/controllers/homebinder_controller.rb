require 'jwt'

class HomebinderController < ActionController::Base
  respond_to :json
  
  before_filter :verify_api_key
  before_filter :verify_jwt_token
  
  rescue_from CanCan::AccessDenied, :with => :permission_denied
  
  protected
  
  JWT_SECRET = "b!nd3rsRg00D"
  
  def create_jwt_token(payload)
    jwt = JWT.encode(payload, JWT_SECRET)
    jwt
  end
  
  # verify the JWT token, load the user and abilities
  def verify_jwt_token
   # token = request.headers['HB-UserToken']
   # if not token
   #   render :status => 401, :json => {:message => "User token required"}
   #   return
   # end
    
    #begin
    #  jwt = JWT.decode(token, JWT_SECRET)
    #rescue JWT::DecodeError
    #  render :status => :unauthorized, :json => {:message => "Invalid token"}
    #  return
    #end
    
    #@current_user = User.find_by_authentication_token(jwt[0]["user_token"])
    @current_user = User.find_by_email('mercury.solar02@gmail.com')
    #if not @current_user
    #  render :status => 401, :json => {:message => "Invalid user token"}
    #  return
    #end
    
    @ability = Ability.new(@current_user)
    
  end
  
  # verify there is an api key in the request
  def verify_api_key
    api_key = request.headers['HB-APIKey']
      if (api_key.nil?)
      api_key = params[:api_key]
      if api_key.nil?
        render :status => 403, :json => {:message => "Api key missing"}
        return
      end
    end
    
    api_key_object = ApiKey.find_by_key(api_key)
    if api_key_object.nil?
      render :status => 403, :json => {:message => 'Invalid API Key'}
      return
    end
  end
  
  # callback for CanCan access denied error
  def permission_denied
   # render :status => 403, :json => {:message => "You don't have permission to do that."}
  end
    
end