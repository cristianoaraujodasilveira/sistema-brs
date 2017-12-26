class AddClientClasses < ActiveRecord::Migration
	def change
		ClientClass.create([
			{name: 'Matriz'},
			{name: 'Filial'}
			])
	end
end
