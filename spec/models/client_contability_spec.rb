require 'rails_helper'

RSpec.describe ClientContability, type: :model do
	it 'has a valid factory' do
		expect(create :client_contability).to be_valid
	end

	it { should belong_to :client }
	it { should have_many :phone_users }
	it { should have_many :email_users }
	it { should have_many :contability_contacts }
	it { should have_many :contability_secondary_contacts }
end
