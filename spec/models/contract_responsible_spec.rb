require 'rails_helper'

RSpec.describe ContractResponsible, type: :model do
	it 'has a valid factory' do
		expect(create :contract_responsible).to be_valid
	end

	it { should validate_presence_of :name }
end
