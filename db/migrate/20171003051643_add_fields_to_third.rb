class AddFieldsToThird < ActiveRecord::Migration
	def change
		add_column :thirds, :cnpj, :string
		add_column :thirds, :phone, :string
	end
end
