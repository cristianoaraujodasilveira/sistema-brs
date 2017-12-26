require 'rails_helper'

RSpec.describe Contract, type: :model do
	it 'has a valid factory' do
		expect(create :contract).to be_valid
	end

	it { should belong_to :client }
	it { should have_many :contract_responsibles }
	it { should have_many :contract_responsible_financials }
	it { should have_many :contract_payments }

	context 'Step 3' do
		before { allow(subject).to receive(:step) { 3 } }
		it { should validate_presence_of :monthly_fixed_payment }
		it { should validate_presence_of :comission_fixed_payment }
	end

end
