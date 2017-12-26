require 'rails_helper'

RSpec.describe PieceResult, type: :model do
	it 'has a valid factory' do
		expect(create :piece_result).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :name }
	end
end
