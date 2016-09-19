class Api::V1::ProjectStatusesController < Api::V1::ApiController
  def index
    render json: ProjectStatus.all
  end
end