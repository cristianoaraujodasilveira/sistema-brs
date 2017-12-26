require 'rails_helper'

RSpec.describe PaymentScope, type: :model do
	it 'has a valid factory' do
		expect(create :payment_scope).to be_valid
	end
end
