class AddFieldToSector < ActiveRecord::Migration
	def change
		add_column :sectors, :department, :string
	end
end
