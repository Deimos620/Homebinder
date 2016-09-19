class FixParterLogoIdFields < ActiveRecord::Migration
  def change
    remove_column :partners, :binder_logo
    remove_column :partners, :sellers_logo
    add_column :partners, :binder_logo_id, :integer
    add_column :partners, :sellers_logo_id, :integer
  end
end
