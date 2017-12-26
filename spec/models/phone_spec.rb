require 'rails_helper'

RSpec.describe Phone, type: :model do
	it 'has a valid factory' do
		expect(create :phone).to be_valid
	end
end
