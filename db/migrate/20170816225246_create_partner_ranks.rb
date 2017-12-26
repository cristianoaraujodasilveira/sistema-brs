class CreatePartnerRanks < ActiveRecord::Migration
	def change
		create_table :partner_ranks do |t|
			t.string :name

			t.timestamps null: false
		end
		PartnerRank.create([
			{ name: '1º'},
			{ name: '2º'},
			{ name: '3º'},
			{ name: '4º'},
			{ name: '5º'},
			{ name: '6º'},
			{ name: '7º'},
			{ name: '8º'},
			{ name: '9º'},
			{ name: '10º'}
			])
	end
end
