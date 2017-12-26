require 'rails_helper'

RSpec.describe ClientBank, type: :model do
  it 'has a valid factory' do
		expect(create :client_bank).to be_valid
	end

	it { should validate_presence_of :owner_account }
	it { should validate_presence_of :bank_code }
	it { should validate_presence_of :agency_number }
	it { should validate_presence_of :agency_name }
	it { should validate_presence_of :account_bank_type_id }
	
	it { should belong_to :client }
	it { should belong_to :account_bank_type }
end
