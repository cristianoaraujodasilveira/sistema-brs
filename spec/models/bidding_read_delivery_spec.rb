require 'rails_helper'

RSpec.describe BiddingReadDelivery, type: :model do
	it 'has a valid factory' do
		expect(create :bidding_read_delivery).to be_valid
	end
end
