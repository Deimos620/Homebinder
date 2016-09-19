attributes :id, :binder_id, :name, :area_type, :dimensions, :details
child :structures, :object_root => false do
	attributes :id, :name
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end