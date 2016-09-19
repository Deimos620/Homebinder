class CreateAreasPaints < ActiveRecord::Migration
  def change
    create_table :areas_paints, :id => false do |t|
      t.references :area
      t.references :paint
    end
  end
end
