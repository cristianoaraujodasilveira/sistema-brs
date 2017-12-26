require 'rails_helper'

RSpec.describe ProposalSituation, type: :model do
	it 'has a valid factory' do
		expect(create :proposal_situation).to be_valid
	end

	it { should validate_presence_of :name }
	it { should have_many :proposals }
end
