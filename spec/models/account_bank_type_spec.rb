require 'rails_helper'

RSpec.describe AccountBankType, type: :model do
	it 'has a valid factory' do
		expect(create :account_bank_type).to be_valid
	end
end
