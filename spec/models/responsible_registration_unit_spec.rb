require 'rails_helper'

RSpec.describe ResponsibleRegistrationUnit, type: :model do
	it 'has a valid factory' do
		expect(create :responsible_registration_unit).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :name }
	end

	describe 'Relations' do
		it { should belong_to :registration_unit }
		it { should have_many :phone_users }
		it { should have_many :email_users }
	end
end
