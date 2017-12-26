require 'rails_helper'

RSpec.describe Unit, type: :model do
	it 'has a valid factory' do
		expect(create :unit).to be_valid
	end
end
