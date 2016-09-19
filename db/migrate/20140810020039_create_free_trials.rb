class CreateFreeTrials < ActiveRecord::Migration
  def change
    create_table :free_trials do |t|
      t.string      :name
      t.string      :email
      t.string      :partner_type
      t.string      :trial_type
      t.string      :status
      t.timestamps
    end
  end
end
