attributes :id, :binder_id, :account_number, :contact, :details
child :contractor do
	attributes :id, :name, :contractor_type, :phone, :email, :url
	child :address do
		attributes :country, :name, :address1, :address2, :city, :state, :zip
	end
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end

