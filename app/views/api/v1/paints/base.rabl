attributes :id, :binder_id, :name, :paint_type, :manufacturer, :code, :makeup, :details
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
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end