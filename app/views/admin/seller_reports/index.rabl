collection @seller_reports
attributes :id, :code, :public, :created_at
child :binder, :object_root => false do
	child :property, :object_root => false do 
		attributes :address1, :address2, :city, :state, :zip
	end
	child :partner, :object_root => false do
		attributes :name, :code, :partner_type
		child :seller_report_logo => :seller_report_logo do
			attributes :name, :location
		end
	end
    node :owner do |b|
        b.get_owner.email unless b.get_owner.nil?
    end
end