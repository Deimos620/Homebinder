class Api::V1::ConstructionTypesController < Api::V1::ApiController
  def index
    render json: ConstructionType.available(@current_user.id)
  end
end