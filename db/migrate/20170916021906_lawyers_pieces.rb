class LawyersPieces < ActiveRecord::Migration
	def change
		create_table :lawyers_pieces do |t|
			t.references :lawyer, index: true
			t.references :piece, index: true

			t.timestamps
		end
	end
end
