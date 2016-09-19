class Api::V1::StoresController < Api::V1::ApiController
  def index
    @stores = Store.available(@current_user.id)
  end
end
