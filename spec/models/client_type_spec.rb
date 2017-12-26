require 'rails_helper'

RSpec.describe ClientType, type: :model do
	it 'has a valid factory' do
		expect(create :client_type).to be_valid
	end
end
