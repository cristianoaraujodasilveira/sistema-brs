require 'rails_helper'

RSpec.describe BiddingResponsible, type: :model do
	it 'has a valid factory' do
		expect(create :bidding_responsible).to be_valid
	end
	
	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :bidding }
	end
end
