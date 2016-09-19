attributes :id, :binder_id, :maintenance_cycle, :name, :details, :interval
node :do_date do |m|
	m.do_date
end
node :last_event_date do |m|
	m.get_last_completed_date
end
node :permissions do |m|
	partial('api/v1/permissions/show', :object => m)
end