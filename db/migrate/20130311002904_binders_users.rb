class BindersUsers < ActiveRecord::Migration
  def change
    create_table :binders_users, :id => false do |t|
      t.references :binder
      t.references :user
    end
  end
end
