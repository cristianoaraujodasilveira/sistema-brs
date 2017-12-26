require 'rails_helper'

RSpec.describe Result, type: :model do
	it 'has a valid factory' do
		expect(create :result).to be_valid
	end
end
