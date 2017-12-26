class AddFieldsToLawyers < ActiveRecord::Migration
	def change
		add_reference :lawyers, :state, index: true, foreign_key: true
		add_reference :lawyers, :city, index: true, foreign_key: true
	end
end
