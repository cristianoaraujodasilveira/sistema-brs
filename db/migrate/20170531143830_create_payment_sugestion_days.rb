class CreatePaymentSugestionDays < ActiveRecord::Migration
	def change
		create_table :payment_sugestion_days do |t|
			t.string :name

			t.timestamps null: false
		end

		PaymentSugestionDay.create([
			{name: '5'},
			{name: '10'},
			{name: '15'},
			{name: '20'},
			{name: '25'},
			{name: '30'}
			])
	end
end
