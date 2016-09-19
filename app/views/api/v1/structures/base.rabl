attributes :id, :binder_id, :name, :construction_style, :construction_type, :year_built, :beds, :baths, :sq_ft, :heat_type, :heat_source, :details
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end