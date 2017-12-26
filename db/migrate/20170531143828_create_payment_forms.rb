class CreatePaymentForms < ActiveRecord::Migration
	def change
		create_table :payment_forms do |t|
			t.string :name

			t.timestamps null: false
		end
		PaymentForm.create([
			{name: 'Boleto'},
			{name: 'Transferência'},
			{name: 'Cheque'},
			{name: 'Espécie'},
			{name: 'Cartão de crédito'},
			{name: 'Permuta'}
			])
	end
end
