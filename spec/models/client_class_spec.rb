require 'rails_helper'

RSpec.describe ClientClass, type: :model do
	it 'has a valid factory' do
		expect(create :client_class).to be_valid
	end
end
