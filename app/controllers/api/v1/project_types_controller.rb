class Api::V1::ProjectTypesController < Api::V1::ApiController
  def index
    render json: ProjectType.available(@current_user.id)
  end
end