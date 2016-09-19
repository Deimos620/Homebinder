class Api::V1::PaintManufacturersController < Api::V1::ApiController
  def index
    render json: PaintManufacturer.available(@current_user.id)
  end
end