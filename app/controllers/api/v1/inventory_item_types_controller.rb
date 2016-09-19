class Api::V1::InventoryItemTypesController < Api::V1::ApiController
  def index
    render json: InventoryItemType.available(@current_user.id)
  end
end