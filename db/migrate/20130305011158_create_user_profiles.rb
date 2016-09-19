class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user                        # the user owning this profile
      t.string :first_name      # the user's first name
      t.string :last_name       # the user's last name
      t.string :home_phone      # user's phone
      t.string :mobile_phone    # cell phone
      t.date   :dob             # birthday
      t.string :sex             # sex
      t.timestamps
    end
  end
end
