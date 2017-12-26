class CreateClientCompanySizes < ActiveRecord::Migration
	def change
		create_table :client_company_sizes do |t|
			t.string :name

			t.timestamps null: false
		end

		ClientCompanySize.create([
			{name: 'ME'},
			{name: 'EPP'},
			{name: 'OE'}
			])
	end
end
