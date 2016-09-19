class UpdateTypeaheadFields < ActiveRecord::Migration
  def change
    # appliances
    add_column :appliances, :appliance_type, :string
    add_column :appliances, :manufacturer, :string
    add_column :appliances, :model, :string
    
    # areas
    add_column :areas, :area_type, :string
    
    # finishes
    add_column :finishes, :make, :string
    add_column :finishes, :model, :string
    
    # inventory items
    add_column :inventory_items, :inventory_item_type, :string
    
    # maintenance items
    add_column :maintenance_items, :maintenance_type, :string
    
    # paints
    add_column :paints, :paint_type, :string
    add_column :paints, :manufacturer, :string
    
    # projects
    add_column :projects, :project_type, :string
    add_column :projects, :status, :string
    
    # structures
    add_column :structures, :building_type, :string
    add_column :structures, :construction_type, :string
    add_column :structures, :construction_style, :string
    add_column :structures, :heat_type, :string
    add_column :structures, :heat_source, :string
  end
end
