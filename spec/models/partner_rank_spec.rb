require 'rails_helper'

RSpec.describe PartnerRank, type: :model do
	it 'has a valid factory' do
		expect(create :partner_rank).to be_valid
	end
end
