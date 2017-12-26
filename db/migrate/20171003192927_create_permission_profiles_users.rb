class CreatePermissionProfilesUsers < ActiveRecord::Migration
	def change
		create_table :permission_profiles_users do |t|
			t.references :permission_profile, index: true
			t.references :user, index: true
		end
	end
end
