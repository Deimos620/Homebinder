class Api::V1::TaggableController < Api::V1::ApiController
  
  def index
    # get the binder
    @binder = Binder.find(params[:binder_id])
    
    # verify the user can read the binder
    @ability.authorize! :read, @binder
    
    # verify the subscription
    verify_subscription
    
    # get the name of the recource being retrieved
    resource = request.path.split('/')[3]
    classname = resource.singularize.classify.constantize
    resourcename = resource.singularize
    
    # check if a tag was passed in
    if params[:tag].nil?
      @resources = classname.where(binder_id: params[:binder_id])
    else
      @resources = classname.joins(:tags).where(tags: {tag: params[:tag]})
    end
  end
  
  def show
    # get the name of the recource being retrieved
    resource, id = request.path.split('/')[3,4]
    classname = resource.singularize.classify.constantize
    
    # find the resource
    @resource = classname.find(id)
    
    # did we find it
    render status: :not_foud unless not @resource.nil?
    
    # check if the user can read it
    @ability.authorize! :read, @resource
    
    # verify the subscription
    @binder = Binder.find(@resource.binder_id)
    verify_subscription
  end
  
  def create
    # get the type of resource being created
    resource = request.path.split('/')[3]
    classname = resource.singularize.classify.constantize
    resourcename = resource.singularize
    symbol = resourcename.parameterize.underscore.to_sym
    
    #get the tag list
    tag_list = params[symbol][:tags_attributes]
    params[symbol].delete(:tags_attributes) unless tag_list.nil?
    
    # create the new resource
    @resource = classname.new(params[symbol])
    @resource.created_by = @current_user.id
    
    # check if the user can create
    @binder = Binder.find(@resource.binder_id)
    @ability.authorize! :create, @binder
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        @resource.tags.new(param_tag)
      end
    end
    
    # save the resource
    if not @resource.save
      render status: :unprocessable_entity, json: @resource.errors
    end
  end
  
  def update
    # get the name and id of the recource being updated
    resource, id = request.path.split('/')[3,4]
    classname = resource.singularize.classify.constantize
    resourcename = resource.singularize
    symbol = resourcename.parameterize.underscore.to_sym
    
    # get the tag list
    tag_list = params[symbol][:tags_attributes]
    params[symbol].delete(:tags_attributes) unless tag_list.nil?
    
    # get the area being updated
    @resource = classname.includes(:tags).find(id)

    # check if the user can update the area
    @ability.authorize! :write, @resource
    
    # get the delete list
    delete_list = TagManager.get_delete_list(@resource, tag_list)
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        if @resource.tags.where(:tag => param_tag[:tag]).length == 0
          @resource.tags.new(param_tag)
        end
      end
    end

    # update
    if @resource.update_attributes(params[symbol])
      # delete any tags we need to remove
      delete_list.each do |delete_me|
        delete_me.destroy
      end
    else
      render status: :unprocessable_entity, json: @resource.errors
    end
  end
  
  def destroy
    # get the name and id of the recource being deleted
    resource, id = request.path.split('/')[3,4]
    classname = resource.singularize.classify.constantize
    
    # load the area to be destroyed
    @resource = classname.find(id)
    
    # check if the user can delete the area
    @ability.authorize! :destroy, @resource
    
    # delete the area
    @resource.destroy
    
    # delete any tags referencing the deleted item
    tagName = classname.to_s.downcase << '_' << id
    TagManager.delete_tag_references(tagName)
    
    head :no_content
  end
  
end