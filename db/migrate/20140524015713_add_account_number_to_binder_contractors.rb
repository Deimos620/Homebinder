class AddAccountNumberToBinderContractors < ActiveRecord::Migration
  def change
    add_column :binder_contractors, :account_number, :string
  end
end
