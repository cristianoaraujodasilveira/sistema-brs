FactoryGirl.define do
	factory :piece_historic_situation do
		association :user
		association :piece
		association :old_piece_situation, factory: :piece_situation
		association :new_piece_situation, factory: :piece_situation
	end
end
