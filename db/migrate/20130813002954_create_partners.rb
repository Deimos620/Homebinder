class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string    :name
      t.string    :phone
      t.string    :email
      t.string    :contact
      t.timestamps
    end
  end
end
