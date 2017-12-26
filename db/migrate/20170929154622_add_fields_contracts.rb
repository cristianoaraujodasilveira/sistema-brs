class AddFieldsContracts < ActiveRecord::Migration
	def change
		add_reference :contracts, :comercial_agent, references: :users
		add_reference :contracts, :intermediary, references: :users

		add_column :contracts, :fixed_value_intermediary, :string
		add_column :contracts, :discount_value_intermediary, :string
		add_column :contracts, :comission_value_intermediary, :string
	end
end
