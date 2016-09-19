class AddDetailsToBinderContractors < ActiveRecord::Migration
  def change
    add_column :binder_contractors, :details, :string
  end
end
