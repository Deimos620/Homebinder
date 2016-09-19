class Admin::LogosController < Admin::AdminController
  
  require "s3"

  def index
    @partner = Partner.includes(:logos).find(params[:partner_id])
    
    @ability.authorize! :read, @partner
    
    @logos = @partner.logos
  end

  def create
    # get the tag list
    tag_list = params[:logo][:tags_attributes]
    params[:logo].delete(:tags_attributes)
    
    @partner = Partner.find(params[:logo][:partner_id])
    
    @ability.authorize! :write, @partner
    
    @logo = Logo.find_by_key(params[:logo][:key])
    if @logo.nil?
      @logo = Logo.new(params[:logo])
      if not tag_list.nil?
        tag_list.each do |param_tag|
          @logo.tags.new(param_tag)
        end
      end
      
      if not @logo.save
        render status: :unprocessable_entity, json: @logo.errors
      end
    else
      @logo = existingImg
    end
  end
  
  def destroy
    @logo = Logo.find(params[:id])
    @partner = Partner.find(@logo.partner_id)
    
    @ability.authorize! :destroy, @partner
    
    @logo.destroy
    head :no_content
  end
  
end