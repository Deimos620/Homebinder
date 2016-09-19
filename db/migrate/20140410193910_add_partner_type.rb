class AddPartnerType < ActiveRecord::Migration
  def change
    add_column :partners, :partner_type, :string
  end
end
