class AddPropertyTypeToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :property_type, :string
  end
end
