attributes :id, :name, :status, :project_type, :start_date, :end_date, :details
node :cost do |s|
	s.cost.cents
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end