class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string      :token
      t.string      :user_token
      t.references  :binder
      t.timestamps
    end
  end
end
