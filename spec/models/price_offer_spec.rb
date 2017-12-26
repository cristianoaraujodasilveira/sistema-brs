require 'rails_helper'

RSpec.describe PriceOffer, type: :model do
	it 'has a valid factory' do
		expect(create :price_offer).to be_valid
	end
end
