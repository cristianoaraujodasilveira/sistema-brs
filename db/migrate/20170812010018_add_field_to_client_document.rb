class AddFieldToClientDocument < ActiveRecord::Migration
	def change
		add_column :client_documents, :emission_date, :date
	end
end
