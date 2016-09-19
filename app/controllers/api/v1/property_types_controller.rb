class Api::V1::PropertyTypesController < Api::V1::ApiController
  def index
    render json: PropertyType.all.map { |type| type.name }
  end
end