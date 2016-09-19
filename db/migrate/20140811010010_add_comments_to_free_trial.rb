class AddCommentsToFreeTrial < ActiveRecord::Migration
  def change
    add_column :free_trials, :comments, :string
  end
end
