class CreateAccountBankTypes < ActiveRecord::Migration
	def change
		create_table :account_bank_types do |t|
			t.string :name

			t.timestamps null: false
		end
		AccountBankType.create([
			{name: 'Conta corrente'},
			{name: 'Conta poupança'}
			])
	end
end
