class Api::V1::DocumentsController < Api::V1::TaggableController
  
  require "s3"

  def create
    existingDoc = Document.find_by_key(params[:document][:key])
    if existingDoc.nil?
      super
    else
      @resource = existingDoc
      @resource.update_attributes(params[:document])
    end
  end
 
end
