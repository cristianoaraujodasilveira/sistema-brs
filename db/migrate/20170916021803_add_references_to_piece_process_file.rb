class AddReferencesToPieceProcessFile < ActiveRecord::Migration
	def change
		add_reference :piece_process_files, :piece, index: true, foreign_key: true
	end
end
