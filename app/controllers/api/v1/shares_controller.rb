class Api::V1::SharesController < Api::V1::ApiController
  def index
    if not params[:shared_with].nil?
        return @shares = Share.where(:shared_with_email => @current_user.email)
    end
    if not params[:shared_by].nil?
      return @shares = Share.where(:shared_by_id => @current_user)
    end
    
    load_sharable
    @shares = @sharable.shares
  end
 
  def create
    load_sharable
    @share = @sharable.shares.new(params[:share])
    @share.status = 'pending'
    @share.shared_by_id = @current_user.id
    if @share.check_for_existing_role?
      render status: :bad_request, json: "The binder has already been shared with the user"
      return
    end
    if not @share.save
      render status: :unprocessable_entity, json: @share.errors
    end
  end

  def update
    @share = Share.find(params[:id])
    
    raise CanCan::AccessDenied if @share.shared_with_email != @current_user.email
    
    if params[:share][:status] == 'accepted'
      accept
      return
    end
    
    if params[:share][:status] == 'rejected'
      reject
    end
  end

  def destroy
    @share = Share.find(params[:id])
    
    raise CanCan::AccessDenied if @share.shared_by_id != @current_user.id
    
    @share.stop
    @share.destroy

    head :no_content
  end
  
  def accept
    @share = Share.find(params[:id])
    @share.accept
    if @share.shared_with_id
      @share.save
    else
       # no user account. require the user to sign up
    end
  end
  
  def reject    
    @share = Share.find(params[:id])
    @share.stop
    @share.destroy
  end
  
private
 
  def load_sharable
    resource, id = request.path.split('/')[3,4]
    @sharable = resource.singularize.classify.constantize.find(id)
  end

  def find_sharable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
