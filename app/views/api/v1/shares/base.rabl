attributes :id, :shared_by_id, :shared_with_email, :sharable_id, :sharable_type, :role_name, :status
node :shared_by_email do |s|
	s.get_shared_by_email
end
node :shared_name do |s|
	s.get_shared_name
end
