class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if not user.nil?
      get_admin_rights(user)
      get_partner_assignment_rights(user)
      get_subscription_rights(user)
      get_transfer_rights(user)
      get_create_rights(user)
      get_read_rights(user)
      get_write_rights(user)
      get_destroy_rights(user)
      get_share_rights(user)
      get_report_rights(user)
    end
  end
  
  def get_admin_rights(user)
    if user.has_role? :admin
      can :manage, :all
    end
  end
  
  def get_partner_assignment_rights(user)
    if user.has_role?(:admin) ||
      user.has_role?(:partner_admin)
      can :assign_parter_to_binder, Binder
    end
  end
  
  def get_subscription_rights(user)
    can :subscribe, Binder, :id => Binder.with_role(:owner, user).map(&:id)
  end
  
  def get_transfer_rights(user)
    can :transfer, Binder, :id => Binder.with_role(:owner, user).map(&:id)
  end
  
  def get_create_rights(user)
    # create permissions
    can :create, Binder, :id => Binder.with_role(:owner, user).map(&:id)
    can :create, Binder, :id => Binder.with_role(:co_owner, user).map(&:id)
    can :create, Binder, :id => Binder.with_role(:partner_admin, user).map(&:id)
    can :create, Binder, :id => Binder.with_role(:broker, user).map(&:id)
    # When we are creating an object we check if the user has create rights
    # on the binder
=begin
    can :create, Structure do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Area do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Appliance do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, BinderContractor do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Finish do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Paint do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Project do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, MaintenanceItem do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, MaintenanceEvent do |item|
      evt = MaintenanceItem.find(item.maintenance_item_id)
      binder = Binder.find(evt.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, InventoryItem do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Note do |item|
      notable = item.get_notable
      can? :write, notable
    end
    can :create, Image do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :create, Document do |item|
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
=end
  end
  
  def can_read_item(user, item)
    # check on the item itself first. If not there then the binder
    if user.has_role?(:reader, item) || user.has_role?(:reader_writer, item)
      true
    else
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder) || user.has_role?(:reader, binder) || user.has_role?(:partner_admin, binder) || user.has_role?(:broker, binder)
    end
  end
  
  def get_read_rights(user)
    # read permissions
    can :read, Binder, :id => Binder.with_role(:owner, user).map(&:id)
    can :read, Binder, :id => Binder.with_role(:co_owner, user).map(&:id)
    can :read, Binder, :id => Binder.with_role(:reader, user).map(&:id)
    can :read, Binder, :id => Binder.with_role(:partner_admin, user).map(&:id)
    can :read, Binder, :id => Binder.with_role(:broker, user).map(&:id)
    can :read, Structure do |item|
      can_read_item(user, item)
    end
    can :read, Area do |item|
      can_read_item(user, item)
    end
    can :read, Appliance do |item|
      can_read_item(user, item)
    end
    can :read, BinderContractor do |item|
      can_read_item(user, item)
    end
    can :read, Finish do |item|
      can_read_item(user, item)
    end
    can :read, Paint do |item|
      can_read_item(user, item)
    end
    can :read, Project do |item|
      can_read_item(user, item)
    end
    can :read, MaintenanceItem do |item|
      can_read_item(user, item)
     end
    can :read, MaintenanceEvent do |item|
      if user.has_role?(:reader, item) || user.has_role?(:reader_writer, item)
        true
      else
        evt = MaintenanceItem.find(item.maintenance_item_id)
        binder = Binder.find(evt.binder_id)
        user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder) || user.has_role?(:reader, binder)
      end
    end
    can :read, InventoryItem do |item|
      can_read_item(user, item)
    end
    can :read, Receipt do |item|
      can_read_item(user, item)
    end
    can :read, Document do |item|
      can_read_item(user, item)
    end
    can :read, Image do |item|
      can_read_item(user, item)
    end  
    can :read, SellerReport do |item|
      can_read_item(user, item)
    end
  end
  
  def can_write_item(user, item)
    if user.has_role?(:reader_writer, item)
      true
    else
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder) || user.has_role?(:partner_admin, binder) || user.has_role?(:broker, binder)
    end
  end
  
  def get_write_rights(user)
    # write permissions
    can :write, Binder, :id => Binder.with_role(:owner, user).map(&:id)
    can :write, Binder, :id => Binder.with_role(:co_owner, user).map(&:id)
    can :write, Binder, :id => Binder.with_role(:partner_admin, user).map(&:id)
    can :write, Binder, :id => Binder.with_role(:broker, user).map(&:id)
    can :write, Structure do |item|
      can_write_item(user, item)
    end
    can :write, Area do |item|
      can_write_item(user, item)
    end
    can :write, Appliance do |item|
      can_write_item(user, item)
    end
    can :write, BinderContractor do |item|
      can_write_item(user, item)
    end
    can :write, Finish do |item|
      can_write_item(user, item)
    end
    can :write, Paint do |item|
      can_write_item(user, item)
    end
    can :write, Project do |item|
      can_write_item(user, item)
    end
    can :write, MaintenanceItem do |item|
      can_write_item(user, item)
    end
    can :write, MaintenanceEvent do |item|
      if user.has_role?(:reader_writer, item)
        true
      else
        evt = MaintenanceItem.find(item.maintenance_item_id)
        binder = Binder.find(evt.binder_id)
        user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
      end
    end
    can :write, InventoryItem do |item|
      can_write_item(user, item)
    end
    can :write, Receipt do |item|
      can_write_item(user, item)
    end
    can :write, Document do |item|
      can_write_item(user, item)
    end
    can :write, Image do |item|
      can_write_item(user, item)
    end
    can :write, SellerReport do |item|
      can_read_item(user, item)
    end
  end
  
  def can_destroy_item(user, item)
    if user.has_role?(:owner, item) || user.has_role?(:co_owner, item)
      true
    else
      binder = Binder.find(item.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder) || user.has_role?(:partner_admin, binder) || user.has_role?(:broker, binder)
    end
  end
  
  def get_destroy_rights(user)
    # destroy permissions
    can :destroy, Binder, :id => Binder.with_role(:owner, user).map(&:id)
    can :destroy, Binder, :id => Binder.with_role(:co_owner, user).map(&:id)
    can :destroy, Binder, :id => Binder.with_role(:partner_admin, user).map(&:id)
    can :destroy, Binder, :id => Binder.with_role(:broker, user).map(&:id)
    can :destroy, Structure do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Area do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Appliance do |item|
      can_destroy_item(user, item)
    end
    can :destroy, BinderContractor do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Finish do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Paint do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Project do |item|
      can_destroy_item(user, item)
    end
    can :destroy, MaintenanceItem do |item|
      can_destroy_item(user, item)
    end
    can :destroy, MaintenanceEvent do |item|
      evt = MaintenanceItem.find(item.maintenance_item_id)
      binder = Binder.find(evt.binder_id)
      user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
    end
    can :destroy, InventoryItem do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Receipt do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Document do |item|
      can_destroy_item(user, item)
    end
    can :destroy, Image do |item|
      can_destroy_item(user, item)
    end
    can :destroy, SellerReport do |item|
      can_read_item(user, item)
    end
    can :destroy, Note do |item|
      if item.created_by == current_user.id
        true
      else
        notable = item.get_notable
        if notable.class.name.downcase == 'binder'
          user.has_role?(:owner, notable) || user.has_role?(:co_owner, notable)
        else
          binder = Binder.find(notable.binder_id)
          user.has_role?(:owner, binder) || user.has_role?(:co_owner, binder)
        end
      end
    end
  end
  
  def can_share_item(user, item)
    binder = Binder.find(item.binder_id)
    user.has_role? :owner, binder
  end
  
  def get_share_rights(user)
    # Sharing permissions
    can :share, Binder, :id => Binder.with_role(:owner, user).map(&:id)
    # NOTE: for now we are only sharing binders as a whole, not parts
    # of a binder.
=begin
    can :share, Structure do |item|
      can_share_item(user, item)
    end
    can :share, Area do |item|
      can_share_item(user, item)
    end
    can :share, Appliance do |item|
      can_share_item(user, item)
    end
    can :share, BinderContractor do |item|
      can_share_item(user, item)
    end
    can :share, Finish do |item|
      can_share_item(user, item)
    end
    can :share, Paint do |item|
      can_share_item(user, item)
    end
    can :share, Project do |item|
      can_share_item(user, item)
    end
    can :share, MaintenanceItem do |item|
      can_share_item(user, item)
    end
    can :share, MaintenanceEvent do |item|
      evt = MaintenanceItem.find(item.maintenance_item_id)
      binder = Binder.find(evt.binder_id)
      user.has_role? :owner, binder
    end
    can :share, InventoryItem do |item|
      can_share_item(user, item)
    end
    can :share, Document do |item|
      can_share_item(user, item)
    end
    can :share, Image do |item|
      can_share_item(user, item)
    end
=end
  end
  
  def get_report_rights(user)
    can :view_master_report, Binder do |b|
      if b.subscription.plan_id != 'free' and b.subscription.payment_status == 'paid'
        true
      end
    end
  end
  
end
