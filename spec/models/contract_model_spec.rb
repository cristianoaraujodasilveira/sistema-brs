require 'rails_helper'

RSpec.describe ContractModel, type: :model do
	it 'has a valid factory' do
		expect(create :contract_model).to be_valid
	end
end
