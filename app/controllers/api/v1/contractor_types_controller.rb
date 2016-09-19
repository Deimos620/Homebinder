class Api::V1::ContractorTypesController < Api::V1::ApiController
  def index
    render json: ContractorType.available(@current_user.id)
  end
end