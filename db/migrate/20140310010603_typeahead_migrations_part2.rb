class TypeaheadMigrationsPart2 < ActiveRecord::Migration
  def change
   # maintenance items
   add_column :maintenance_items, :maintenance_cycle, :string
   
   # contractors
   add_column :contractors, :contractor_type, :string
  end
end
