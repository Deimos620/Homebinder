class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references  :addressable, :polymorphic => true
      t.string      :name
      t.string      :country
      t.string      :address1
      t.string      :address2
      t.string      :city
      t.string      :state
      t.string      :zip
      t.string      :lat
      t.string      :long
    end
  end
end
