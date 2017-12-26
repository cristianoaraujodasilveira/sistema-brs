require 'rails_helper'

RSpec.describe Email, type: :model do
	it 'has a valid factory' do
		expect(create :email).to be_valid
	end
end
