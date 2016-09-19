class Api::V1::BindersController < Api::V1::ApiController
  def index
    @binders = @current_user.binders.includes(:subscription)
  end
  
  def show
    # load the binder
    @binder = Binder.includes(:subscription).find(params[:id])
    
    # check if the user can read it
    @ability.authorize! :read, @binder
    
    # verify the subscripton
    verify_subscription
  end
  
  def create
    # get the tag list
    @current_user = @current_user = User.find_by_email('mercury.solar02@gmail.com')
    tag_list = params[:binder][:tags_attributes]
    params[:binder].delete(:tags_attributes) unless tag_list.nil?
    
    # create the new binder
    @binder = Binder.new(params[:binder])
    @binder.created_by = @current_user.id
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        @binder.tags.new(param_tag)
      end
    end
    
    if @binder.save
      # make the current user the owner of the binder
      @current_user.add_role :owner, @binder
      
      #add the binder to the current user's list of binders
      @current_user.binders << @binder
      
      # set the subscription level for the binder to free
      subscription = Subscription.new(binder_id: @binder.id, plan_id: 'free')
      subscription.save

      # if this is set to primary make sure there are no other primaries
      Binder.where(:primary => true).each do |primary|
        if primary.id != @binder.id
          primary.primary = false;
          primary.save
        end
      end
      
      # refresh the ability class
      @ability = Ability.new(@current_user)
    else
      render status: :unprocessable_entity, json: @binder.errors
    end
  end
  
  def update 
    # get the tag list
    tag_list = params[:binder][:tags_attributes]
    params[:binder].delete(:tags_attributes) unless tag_list.nil?
    
    # get the binder
    @binder = Binder.find(params[:id])
   
    # check if the user can update it
    @ability.authorize! :write, @binder
    
    # taking the easy way out here or removing the existing partner tag.
    # it will get updated on the save
    partner_tags = @binder.tags.where(["tag LIKE :tag", {:tag => 'partner_%'}])
    if partner_tags.length > 0
      delete_tag = partner_tags.first
    end
    
    # add the tags
    if not tag_list.nil?
      tag_list.each do |param_tag|
        @binder.tags.new(param_tag)
      end
    end

    # save the binder
    if @binder.update_attributes(params[:binder])
      delete_tag.destroy unless delete_tag.nil?
      
      # if this is set to primary make sure there are no other primaries
      Binder.where(:primary => true).each do |primary|
        if primary.id != @binder.id
          primary.primary = false;
          primary.save
        end
      end
    else
      render status: :unprocessable_entity, json: @binder.errors
    end
  end
  
  def destroy
    # get the binder
    @binder = Binder.find(params[:id])
    
    # check if the user can delete it
    @ability.authorize! :destroy, @binder

    # delete the binder
    @binder.destroy
    
    head :no_content
  end
  
end
