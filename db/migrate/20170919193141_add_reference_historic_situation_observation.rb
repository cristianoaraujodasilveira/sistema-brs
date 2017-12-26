class AddReferenceHistoricSituationObservation < ActiveRecord::Migration
	def change
		add_reference :piece_historic_situations, :observation, index: true, foreign_key: true
	end
end
