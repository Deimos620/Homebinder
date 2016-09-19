class Api::V1::ApplianceManufacturersController < Api::V1::ApiController
  def index
    render json: ApplianceManufacturer.available(@current_user.id)
  end
end