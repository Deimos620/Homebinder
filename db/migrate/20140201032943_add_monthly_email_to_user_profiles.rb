class AddMonthlyEmailToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :monthly_email, :boolean, :default => TRUE  
  end
end
