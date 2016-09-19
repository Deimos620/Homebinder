class Api::V1::ImagesController < Api::V1::TaggableController
  
  require "s3"

  def create
    existingImg = Image.find_by_key(params[:image][:key])
    if existingImg.nil?
      super
    else
      @resource = existingImg
      @resource.update_attributes(params[:image])
    end
  end
 
end
