class Api::V1::MaintenanceCyclesController < Api::V1::ApiController
  def index
    render json: MaintenanceCycle.all
  end
end