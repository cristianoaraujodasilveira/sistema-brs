class CreateFinancialTickets < ActiveRecord::Migration
	def change
		create_table :financial_tickets do |t|
			t.references :financial, index: true, foreign_key: true
			t.date :emission_date
			t.date :due_date
			t.attachment :ticket
			
			t.timestamps null: false
		end
	end
end
