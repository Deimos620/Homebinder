class Api::V1::HeatTypesController < Api::V1::ApiController
  def index
    render json: HeatType.available(@current_user.id)
  end
end