class Api::V1::FinishMakesController < Api::V1::ApiController
  def index
    render json: FinishMake.available(@current_user.id)
  end
end