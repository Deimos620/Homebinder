class Admin::PartnersController < Admin::AdminController
  
  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find(params[:id])
  end

  def create
    # get the tag list
    tag_list = params[:partner][:tags_attributes]
    params[:partner].delete(:tags_attributes) unless tag_list.nil?
    
    @partner = Partner.new(params[:partner])
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        @partner.tags.new(param_tag)
      end
    end
    
    if not @partner.save
      render status: :unprocessable_entity, json: @partner.errors
    end
  end

  def update
    # get the tag list
    tag_list = params[:partner][:tags_attributes]
    params[:partner].delete(:tags_attributes) unless tag_list.nil?
    
    @partner = Partner.find(params[:id])
    
    # get the delete list
    delete_list = TagManager.get_delete_list(@partner, tag_list)
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        if @partner.tags.where(:tag => param_tag[:tag]).length == 0
          @partner.tags.new(param_tag)
        end
      end
    end
    
    if @partner.update_attributes(params[:partner])
      # delete any tags we need to remove
      delete_list.each do |delete_me|
        delete_me.destroy
      end
    else
      render status: :unprocessable_entity, json: @resource.errors
    end
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy
    head :no_content
  end
  
end