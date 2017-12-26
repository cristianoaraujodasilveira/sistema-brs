require 'rails_helper'

RSpec.describe ParticipationResult, type: :model do
	it 'has a valid factory' do
		expect(create :participation_result).to be_valid
	end
end
