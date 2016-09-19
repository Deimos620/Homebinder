attribute :id, :name, :details, :deductable
child :purchase do
	attributes :store, :date
	node :price do |p|
		p.price.cents
	end
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end