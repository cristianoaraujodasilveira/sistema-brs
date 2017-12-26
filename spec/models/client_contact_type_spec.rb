require 'rails_helper'

RSpec.describe ClientContactType, type: :model do
	it 'has a valid factory' do
		expect(create :client_contact_type).to be_valid
	end
end
