require 'securerandom'

class Api::V1::SessionsController < Api::V1::ApiController
  
  skip_before_filter :verify_session_token,  :only => [:create]
  
  def show
    @session = Session.find_by_token(params[:session_token])
    if @session.nil?
      render :status => 404, :json => {:message => 'Session not found'}
    end
  end
  
  def create
    user_token = params[:user_token]
    if user_token.nil?
      render :status => 403, :json => {:message => 'User token is required'}
    end
    @session = Session.new(token: SecureRandom.hex, user_token: user_token)
  end
  
  def update
    @session = Session.find_by_token(params[:session_token])
    if @session.nil?
      render :status => 404, :json => {:message => 'Session not found'}
    end
    @session.update_attributes(params[:session])
  end
  
  def destroy
    session = Session.find_by_token(params[:session_token])
    session.destroy unless session.nil?
    head :no_content  
  end
  
end