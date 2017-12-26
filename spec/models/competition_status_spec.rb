require 'rails_helper'

RSpec.describe CompetitionStatus, type: :model do
	it 'has a valid factory' do
		expect(create :competition_status).to be_valid
	end
end
