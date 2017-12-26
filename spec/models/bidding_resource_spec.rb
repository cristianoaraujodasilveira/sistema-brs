require 'rails_helper'

RSpec.describe BiddingResource, type: :model do
	it 'has a valid factory' do
		expect(create :bidding_resource).to be_valid
	end

	describe 'Relations' do
		it { should belong_to :bidding }
		it { should belong_to :bidding_proposal }
		it { should have_many :observations }
	end
end
