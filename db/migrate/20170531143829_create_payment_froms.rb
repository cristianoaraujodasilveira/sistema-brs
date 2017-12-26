class CreatePaymentFroms < ActiveRecord::Migration
	def change
		create_table :payment_froms do |t|
			t.string :name

			t.timestamps null: false
		end

		PaymentFrom.create([
			{name: 'Parceiro'},
			{name: 'Cliente'}
			])
	end
end
