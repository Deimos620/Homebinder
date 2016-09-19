class AddContactToBinderContractor < ActiveRecord::Migration
  def change
    add_column :binder_contractors, :contact, :string
  end
end
