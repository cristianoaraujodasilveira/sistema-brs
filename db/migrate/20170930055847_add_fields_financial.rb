class AddFieldsFinancial < ActiveRecord::Migration
	def change
		add_column :financials, :contractual_mulct, :string
		add_column :financials, :reason_contractual_mulct, :string
	end
end
