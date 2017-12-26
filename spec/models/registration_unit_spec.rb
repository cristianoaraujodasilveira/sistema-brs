require 'rails_helper'

RSpec.describe RegistrationUnit, type: :model do
	it 'has a valid factory' do
		expect(create :registration_unit).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :organ_id }
		it { should validate_presence_of :name }
		it { should validate_presence_of :zipcode }
		it { should validate_presence_of :address }
		it { should validate_presence_of :district }
		it { should validate_presence_of :number }
		it { should validate_presence_of :state_id }
		it { should validate_presence_of :city_id }
	end

	describe 'Relations' do
		it { should belong_to :organ }
		it { should belong_to :state }
		it { should belong_to :city }
		it { should belong_to :registration_unit }
		it { should have_many :registration_units }
		it { should have_many :responsible_registration_units }
		it { should have_many :phone_users }
		it { should have_many :email_users }
	end
end
