require 'rails_helper'

RSpec.describe ProcessLocation, type: :model do
	it 'has a valid factory' do
		expect(create :process_location).to be_valid
	end
end
