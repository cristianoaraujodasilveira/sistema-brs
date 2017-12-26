require 'rails_helper'

RSpec.describe PartnerParticipation, type: :model do
	it 'has a valid factory' do
		expect(create :partner_participation).to be_valid
	end
end
