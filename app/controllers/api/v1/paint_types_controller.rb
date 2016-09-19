class Api::V1::PaintTypesController < Api::V1::ApiController
  def index
    render json: PaintType.available(@current_user.id)
  end
end