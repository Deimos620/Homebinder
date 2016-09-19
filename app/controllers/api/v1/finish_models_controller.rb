class Api::V1::FinishModelsController < Api::V1::ApiController
  def index
    render json: FinishModel.available(@current_user.id)
  end
end