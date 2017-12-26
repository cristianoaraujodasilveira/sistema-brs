require 'rails_helper'

RSpec.describe ProposalHistoric, type: :model do
	it 'has a valid factory' do
		expect(create :proposal_historic).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :comment }
	end

	describe 'Relations' do
		it { should belong_to :proposal }
		it { should belong_to :user }
	end
end
