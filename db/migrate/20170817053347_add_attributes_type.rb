class AddAttributesType < ActiveRecord::Migration
	def change
		add_column :observations, :observation_type, :integer
		add_column :attachments, :attachment_type, :integer
		add_column :responsibles, :emission_date, :date
	end
end
