class Api::V1::FreeTrialsController < Api::V1::ApiController
  
  skip_before_filter :verify_api_key
  skip_before_filter :verify_jwt_token
  
  def create
    @free_trial = FreeTrial.new(params[:free_trial])
    begin
      FreeTrialService.request_free_trial(@free_trial)
      head :no_content
    rescue UnprocessableException
      render :status => :unprocessable_entity, :json => @free_trial.errors
    rescue BadRequestException
      render :status => bad_request
    end
  end
  
end
