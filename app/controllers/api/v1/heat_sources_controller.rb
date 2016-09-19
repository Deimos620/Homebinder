class Api::V1::HeatSourcesController < Api::V1::ApiController
  def index
    render json: HeatSource.available(@current_user.id)
  end
end