attribute :id, :plan, :payment_status, :card_type, :last4, :subtotal, :discount, :end_date
child :binder do
	attributes :id, :name
	child :property do 
		attributes :country, :address1, :address2, :city, :state, :zip
	end
end