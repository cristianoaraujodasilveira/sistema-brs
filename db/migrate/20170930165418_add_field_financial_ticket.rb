class AddFieldFinancialTicket < ActiveRecord::Migration
	def change
		add_column :financial_tickets, :payment_date, :date
	end
end
