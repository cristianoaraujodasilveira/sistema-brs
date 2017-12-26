require 'rails_helper'

RSpec.describe BidderStatus, type: :model do
	it 'has a valid factory' do
		expect(create :bidder_status).to be_valid
	end
end
