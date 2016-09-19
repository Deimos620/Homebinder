attributes :id, :name, :partner_type, :code, :contact, :phone, :email, :binder_logo_id, :sellers_logo_id
child :binder_logo => :binder_logo do
	attributes :id, :name, :location
end
child :seller_report_logo => :seller_report_logo do
	attributes :id, :name, :location
end