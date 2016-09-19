object @resource

node :can_read do |r|
	@ability.can? :read, r
end
node :can_create do |r|
	@ability.can? :create, r
end
node :can_write do |r|
	@ability.can? :write, r
end
node :can_destroy do |r|
	@ability.can? :write, r
end