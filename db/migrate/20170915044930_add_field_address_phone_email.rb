class AddFieldAddressPhoneEmail < ActiveRecord::Migration
	def change
		add_column :addresses, :address_type, :integer
		add_column :phones, :phone_type, :integer
		add_column :emails, :email_type, :integer
	end
end
