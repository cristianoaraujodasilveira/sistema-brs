class AddProfileType < ActiveRecord::Migration
	def change
		Profile.create([
			{name: 'Diretor'}
			])
	end
end
