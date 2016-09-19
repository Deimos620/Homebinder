class CreateSellerReports < ActiveRecord::Migration
  def change
    create_table :seller_reports do |t|
      t.references  :binder
      t.string      :code
      t.timestamps
    end
  end
end
