object @recallCheck
attributes :page, :total, :last, :pages, :recalls
child :appliance => :appliance do
	attributes :name, :manufacturer, :model, :upc
end
