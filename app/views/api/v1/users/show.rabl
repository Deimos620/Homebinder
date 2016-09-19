object @user
attributes :email, :authentication_token, :global_role
node :can_assign_parter_to_binder do
	@ability.can? :assign_parter_to_binder, Binder
end