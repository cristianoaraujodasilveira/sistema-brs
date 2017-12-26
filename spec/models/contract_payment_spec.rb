require 'rails_helper'

RSpec.describe ContractPayment, type: :model do
	it 'has a valid factory' do
		expect(create :contract_payment).to be_valid
	end

	it { should belong_to :contract }
	it { should belong_to :payment_form }
	it { should belong_to :payment_from }
	it { should belong_to :payment_sugestion_day }

end
