attribute :id, :binder_id, :name, :inventory_item_type, :details
node :value do |i|
	i.value.cents
end
node :permissions do |i|
	partial('api/v1/permissions/show', :object => i)
end