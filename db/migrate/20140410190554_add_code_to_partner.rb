class AddCodeToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :code, :string
  end
end
