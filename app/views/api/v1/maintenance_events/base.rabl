attributes :id, :maintenance_item_id, :contractor_id, :do_date, :completed_date
node :permissions do |m|
	partial('api/v1/permissions/show', :object => m)
end