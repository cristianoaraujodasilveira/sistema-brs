class CreateGoodHabits < ActiveRecord::Migration
	def change
		create_table :good_habits do |t|
			t.string :name

			t.timestamps null: false
		end
		GoodHabit.create([
			{ name: 'ANVISA' },
			{ name: 'CADASTRO TÉCNICO FEDERAL (IBAMA)' },
			{ name: 'BOAS PRÁTICAS' },
			{ name: 'INMETRO' },
			{ name: 'ANTT' },
			{ name: 'CONSELHO REGIONAL' },
			{ name: 'PRODUTO CREDENCIADO' },
			{ name: 'ANATEL' }
			])
	end
end
