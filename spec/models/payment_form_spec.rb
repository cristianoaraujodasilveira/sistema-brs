require 'rails_helper'

RSpec.describe PaymentForm, type: :model do
	it 'has a valid factory' do
		expect(create :payment_form).to be_valid
	end
end
