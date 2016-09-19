attributes :id, :name, :contractor_type, :phone, :email, :url
child :address do
	attributes :country, :name, :address1, :address2, :city, :state, :zip
end