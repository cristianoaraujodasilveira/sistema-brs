require 'rails_helper'

RSpec.describe PaymentSugestionDay, type: :model do
	it 'has a valid factory' do
		expect(create :payment_sugestion_day).to be_valid
	end
end
