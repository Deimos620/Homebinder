class AddLogosToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :binder_logo, :integer
    add_column :partners, :sellers_logo, :integer
  end
end
