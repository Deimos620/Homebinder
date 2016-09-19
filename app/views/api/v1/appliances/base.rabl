attribute :id, :name, :manufacturer, :model, :serial_no, :warranty, :user_guide_url, :details, :last_recall_check, :upc, :install_date
child :purchase do
	attributes :store, :date
	node :price do |p|
		p.price.cents
	end
end
node :permissions do |s|
	partial('api/v1/permissions/show', :object => s)
end