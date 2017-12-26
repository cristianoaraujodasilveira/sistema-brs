class AddReferenceUserToPieceHistoric < ActiveRecord::Migration
	def change
		add_reference :piece_historic_situations, :user, index: true, foreign_key: true
	end
end
