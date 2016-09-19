class Api::V1::UserProfilesController < Api::V1::ApiController
  
  def index
    @user_profile = UserProfile.find_by_user_id(@current_user.id)
  end
  
  def update
    @user_profile = UserProfile.find(params[:id])
    if not @user_profile.update_attributes(params[:user_profile])
      render status: :unprocessable_entity, json: @user_profile.errors
    end
  end

end