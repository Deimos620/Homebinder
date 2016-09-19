attributes :id, :code, :public
child :appliances, :object_root => false do
	attributes :name, :manufacturer, :model, :install_date, :details
end
child :projects, :object_root => false do
	attributes :name, :details, :end_date
end
child :maintenance_items, :object_root => false do
	attributes :name, :details, :interval, :maintenance_cycle
end
child :paints, :object_root => false do
	attributes :name, :details, :manufacturer
end
child :finishes, :object_root => false do
	attributes :name, :details, :make, :model
end
child :contractors, :object_root => false do
	child :contractor, :object_root => false do
		attributes :name, :contractor_type, :phone, :email
	end
end
child :documents, :object_root => false do
    attribute :id, :name, :location
end
child :images, :object_root => false do
    attribute :id, :name, :location
end
child :binder, :object_root => false do
	attributes :id, :name
	child :property, :object_root => false do 
		attributes :address1, :address2, :city, :state, :zip
	end
	child :partner, :object_root => false do
		attributes :name, :code, :partner_type
		child :seller_report_logo => :seller_report_logo do
			attributes :name, :location
		end
	end
	
end

