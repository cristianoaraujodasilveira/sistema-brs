class CreateFinancials < ActiveRecord::Migration
	def change
		create_table :financials do |t|
			t.references :client, index: true, foreign_key: true
			t.references :contract, index: true, foreign_key: true
			t.string :indication_value
			t.string :indication_pessoal

			t.timestamps null: false
		end
	end
end
