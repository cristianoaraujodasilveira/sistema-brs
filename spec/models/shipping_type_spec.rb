require 'rails_helper'

RSpec.describe ShippingType, type: :model do
	it 'has a valid factory' do
		expect(create :shipping_type).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :name }
	end
end
