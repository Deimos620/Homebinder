class Api::V1::AreaTypesController < Api::V1::ApiController
  def index
    render json: AreaType.available(@current_user.id)
  end
end