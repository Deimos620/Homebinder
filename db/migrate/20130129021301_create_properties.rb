class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references  :binder
      t.integer     :property_type_id
      t.string      :apn
      t.string      :country
      t.string      :address1
      t.string      :address2
      t.string      :city
      t.string      :state
      t.string      :zip
      t.string      :county
      t.string      :lat
      t.string      :long
      t.string      :details
      t.decimal     :acres
      t.integer     :created_by
      t.timestamps
    end
  end
end
