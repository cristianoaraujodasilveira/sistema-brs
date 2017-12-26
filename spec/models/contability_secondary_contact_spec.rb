require 'rails_helper'

RSpec.describe ContabilitySecondaryContact, type: :model do
	it 'has a valid factory' do
		expect(create :contability_secondary_contact).to be_valid
	end
	it { should belong_to :client_contability }
end
