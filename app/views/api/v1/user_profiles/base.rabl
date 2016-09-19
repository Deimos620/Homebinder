attributes :id, :user_id, :first_name, :last_name, :home_phone, :mobile_phone, :dob, :sex
child :address do
	attributes :country, :name, :address1, :address2, :city, :state, :zip
end