class TransferService < BaseService
  
  def initialize(current_user, transfer)
    super(current_user)
    @transfer = transfer
  end
  
  def transfer_binder
    @transfer.user_id = @current_user.id
    @transfer.transfer_to = @transfer.transfer_to.downcase
    
    # get the binder being transfered
    @binder = Binder.includes(:subscription).find(@transfer.binder_id)
    
    # if there us no binder we are done
    raise NotFoundException, 'Binder not found' unless @binder
    
    # make sure the user can transfer
    raise PermissionDeniedException unless @ability.can?(:transfer, @binder)
    
    # get the user being transferred to
    @new_owner = User.find_by_email(@transfer.transfer_to)
    
    # prevent transferring to yourself
    if @new_owner and @new_owner.email.downcase == @current_user.email.downcase
      raise BadRequestException, 'You can not transfer a binder to yourself'
    end
    
    # check if the user already has access to the binder
    if @new_owner
      if @new_owner.binders.where(id: @binder.id).length > 0
        raise BadRequestException, 'The transfer to user already has access to the binder'
      end
    end
    
    # set the status to pending
    @transfer.status = 'pending'
    
    # perform the transfer
    if @transfer.transfer_type == 'ownership'
      # remove the binder and access from the current user
      remove_from_current_owner
      
      # if there is a new owner complete the transfer.
      if @new_owner
        complete_ownership_transfer
      end
    else
      # if there is a new owner create a copy of the binder and transfer it.
      if @new_owner
        copy_and_transfer
      end
    end
    
    # save the status of the transfer
    @transfer.save
    
    # send the email
    if @new_owner
      TransferMailer.delay.notify_email(@transfer.transfer_to, @current_user, @binder)
    else
      TransferMailer.delay.notify_unregistered_email(@transfer.transfer_to, @current_user, @binder)
    end
  end
  
  def resume_transfer
    @binder = Binder.find(@transfer.binder_id)
    @new_owner = @current_user
    if @transfer.transfer_type == 'ownership'
      complete_ownership_transfer
    else
      copy_and_transfer
    end
    
    @transfer.save
  end
  
  private
  
  def remove_from_current_owner
    # remove all existing roles on the binder
    users = User.joins(:binders).where(binders: {id: @binder.id})
    users.each do |u|
      # remove the role the user has
      if u.has_role? :owner, @binder
        u.remove_role :owner, @binder
      else if u.has_role? :co_owner, @binder
        u.remove_role :co_owner, @binder
      else if u.has_role? :reader, @binder
        u.remove_role :reader, @binder
      else if u.has_role? :reader_writer, @binder
         u.remove_role :reader_writer, @binder
      else if u.has_role? :partner_admin, @binder
        u.remove_role :partner_admin, @binder
      else if u.has_role? :broker, @binder
        u.remove_role :broker, @binder
      end
      end
      end
      end
      end
      end
    
      #remove the binder from the user's list
      u.binders.delete(@binder)
    end
  
    # cancel the subscription
    @binder.subscription.cancel
  end
  
  def complete_ownership_transfer
    # add owner role to the new owner
    @new_owner.add_role :owner, @binder
    
    # add the binder to the new user
    @new_owner.binders << @binder
    @new_owner.save
    
    # done
    @transfer.status = 'complete'
  end
  
  def copy_and_transfer
    # make a copy of the binder
    @new_binder = copy_item(@binder)
    @new_binder.property = copy_item(@binder.property)
    # copy over the structures
    @binder.structures.each do |s|
      new_s = copy_item(s)
      @new_binder.structures << new_s
    end
    # copy over the areas
    @binder.areas.each do |a|
      new_a = copy_item(a)
      @new_binder.areas << new_a
    end
    # copy over the appliances
    @binder.appliances.each do |a|
      new_a = copy_item(a)
      @new_binder.appliances << new_a
    end
    # copy over the contractors
    @binder.binder_contractors.each do |bc|
      new_bc = copy_item(bc)
      new_bc.account_number = nil
      @new_binder.binder_contractors << new_bc
    end
    # copy over the maintenance
    @binder.maintenance_items.each do |mi|
      new_mi = copy_item(mi)
      me = mi.next_event
      if not me.nil?
        new_mi.do_date = me.do_date
      end
      @new_binder.maintenance_items << new_mi
    end
    # copy over the finishes
    @binder.finishes.each do |f|
      new_f = copy_item(f)
      @new_binder.finishes << new_f
    end
    # copy over the projets
    @binder.projects.each do |p|
      new_p = copy_item(p)
      new_p.cost_cents = 0
      @new_binder.projects << new_p
    end
    # copy over the paints
    @binder.paints.each do |p|
      new_p = copy_item(p)
      @new_binder.paints << new_p
    end
    # save the new binder
    @new_binder.save
    # set the subscription level for the binder to free
    subscription = Subscription.new(binder_id: @new_binder.id, plan_id: 'free')
    subscription.save
    # make the transfer_to user the new owner
    @new_owner.add_role :owner, @new_binder
    # add the binder to the user
    @new_owner.binders << @new_binder
    @new_owner.save
    # done
    @transfer.status = 'complete'
  end
  
  def copy_item(item)
    new_item = item.dup
    new_item.id = nil
    new_item.created_at = nil
    new_item.updated_at = nil
    # copy the purchase
    if item.respond_to?(:purchase) and not item.purchase.nil?
      new_item.purchase = item.purchase.dup
      new_item.purchase.price_cents = 0
    end
    # copy the notes
    if item.respond_to?(:notes)
      item.notes.each do |n|
        new_n = n.dup
        new_n.id = nil
        new_n.created_at = nil
        new_n.updated_at = nil
        new_item.notes << new_n
      end
    end
    # copy the tags
    if item.respond_to?(:tags)
      item.tags.each do |t|
        new_t = t.dup
        new_t.id = nil
        new_t.created_at = nil
        new_t.updated_at = nil
        new_item.tags << new_t
      end
    end
    return new_item
  end
  
end