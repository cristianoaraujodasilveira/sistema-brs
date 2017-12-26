require 'rails_helper'

RSpec.describe PieceHistoricSituation, type: :model do
	it 'has a valid factory' do
		expect(create :piece_historic_situation).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :piece_id }
		it { should validate_presence_of :user_id }
		it { should validate_presence_of :old_piece_situation_id }
		it { should validate_presence_of :new_piece_situation_id }
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :piece }
		it { should belong_to :observation }
		it { should belong_to :old_piece_situation }
		it { should belong_to :new_piece_situation }
	end
end
