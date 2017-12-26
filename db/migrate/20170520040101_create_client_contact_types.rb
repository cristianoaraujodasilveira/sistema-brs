class CreateClientContactTypes < ActiveRecord::Migration
	def change
		create_table :client_contact_types do |t|
			t.string :name

			t.timestamps null: false
		end
		ClientContactType.create([
			{name: 'Comercial'},
			{name: 'Fiscal'}
			])
	end
end
