class Api::V1::ConstructionStylesController < Api::V1::ApiController
  def index
    render json: ConstructionStyle.available(@current_user.id)
  end
end