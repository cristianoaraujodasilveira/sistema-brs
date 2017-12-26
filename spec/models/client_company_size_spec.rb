require 'rails_helper'

RSpec.describe ClientCompanySize, type: :model do
	it 'has a valid factory' do
		expect(create :client_company_size).to be_valid
	end

	it { should validate_presence_of :name }
	it { should have_many :clients }
end
