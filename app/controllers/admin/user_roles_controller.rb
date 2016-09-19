class Admin::UserRolesController < Admin::AdminController
  
  def create
    action = params[:role][:action]
    role_name = params[:role][:role_name]
    
    # lookup the user the role is being applied to
    apply_to = User.find_by_email(params[:role][:apply_to])
    if apply_to.nil?
      render :status => :bad_request, :json => 'No such user'
      return
    end
    
    # check the role
    if not verify_role_name?(role_name)
      render :status => :bad_request, :json => 'Invalid role name'
      return
    end
        
    # update the role
    role_sym = role_name.to_sym
    if action == 'add'
      if not apply_to.has_role? role_sym
        apply_to.add_role role_sym
      end
    else if action == 'remove'
      if apply_to.has_role? role_sym
        apply_to.remove_role role_sym
      end
    else
      render :status => :bad_request, :json => 'action must be add or remove'
    end
    end
    
    # tag the partner
    
    # render success
    render :status => :created, :json => 'Role added'
    
  end
  
  private
  
  def verify_role_name?(role_name)
    return role_name == 'admin' || role_name == 'partner_admin' || role_name == 'broker'
  end
  
end