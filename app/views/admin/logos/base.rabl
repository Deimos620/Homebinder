attribute :id, :name, :location
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end