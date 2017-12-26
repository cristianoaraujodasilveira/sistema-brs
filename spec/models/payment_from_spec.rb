require 'rails_helper'

RSpec.describe PaymentFrom, type: :model do
	it 'has a valid factory' do
		expect(create :payment_from).to be_valid
	end
end
