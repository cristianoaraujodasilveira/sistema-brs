class CreateContractResponsibleFinancials < ActiveRecord::Migration
	def change
		create_table :contract_responsible_financials do |t|
			t.references :contract, index: true, foreign_key: true
			t.string :name
			t.string :office
			t.string :department
			t.string :whatsapp
			t.string :skype
			
			t.timestamps null: false
		end
	end
end
