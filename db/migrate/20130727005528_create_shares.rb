class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer     :shared_by_id
      t.integer     :shared_with_id
      t.string      :shared_with_email
      t.references  :sharable, :polymorphic => :true
      t.string      :role_name
      t.string      :status
      t.boolean     :expirable
      t.date        :expires_on  
      t.timestamps
    end
    
    add_index :shares, :shared_by_id
    add_index :shares, :shared_with_id
    add_index :shares, :shared_with_email
  end
end
