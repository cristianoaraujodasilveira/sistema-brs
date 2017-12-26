require 'rails_helper'

RSpec.describe AccreditationPresential, type: :model do
	it 'has a valid factory' do
		expect(create :accreditation_presential).to be_valid
	end
end
