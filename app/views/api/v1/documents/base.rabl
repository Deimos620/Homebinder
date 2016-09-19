attribute :id, :name, :location, :file_size
child :seller_report_item, :object_root => false do
    attributes :include, :sort_index
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end