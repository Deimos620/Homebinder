attributes :id, :name, :primary, :details, :partner
child :property do 
	attributes :id, :property_type, :country, :address1, :address2, :city, :state, :zip, :acres
end
child :subscription do
	attributes :id, :plan_id, :payment_status
end
child :seller_report do
	attributes :code, :public
end
child :partner, :object_root => false do
	attributes :id, :name, :code, :partner_type
	child :binder_logo => :binder_logo do
		attributes :id, :name, :location
	end
	child :seller_report_logo => :seller_report_logo do
		attributes :id, :name, :location
	end
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end
node :can_subscribe do |b|
	@ability.can? :subscribe, b
end
node :can_share do |b|
	@ability.can? :share, b
end
node :can_transfer do |b|
	@ability.can? :transfer, b
end
node :can_view_master_report do |b|
	@ability.can? :view_master_report, b
end
node :can_create_seller_report do |b|
	@ability.can? :create, b
end
node :can_edit_seller_report do |b|
    @ability.can? :write, b
end
node :subscription_info do |b|
	b.get_subscription_detail
end