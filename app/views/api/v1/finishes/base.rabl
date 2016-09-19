attribute :id, :binder_id, :name, :make, :model, :style_color, :details
child :purchase do
	attributes :store, :date
	node :price do |p|
		p.price.cents
	end
end
child :structures, :object_root => false do
	attributes :id, :name
end
child :areas, :object_root => false do
	attributes :id, :name
end
node :permissions do |f|
	partial('api/v1/permissions/show', :object => f)
end