require 'rails_helper'

RSpec.describe Organ, type: :model do
	it 'has a valid factory' do
		expect(create :organ).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :sphere_id }
		it { should validate_presence_of :name }
		it { should validate_presence_of :phone }
		it { should validate_presence_of :cnpj }
		it { should validate_presence_of :zipcode }
		it { should validate_presence_of :address }
		it { should validate_presence_of :district }
		it { should validate_presence_of :number }
		it { should validate_presence_of :state_id }
		it { should validate_presence_of :city_id }
		it { should validate_uniqueness_of :cnpj }
	end

	describe 'Relations' do
		it { should belong_to :city }
		it { should belong_to :state }
		it { should belong_to :sphere }
		it { should belong_to :organ }
		it { should have_many :sectors}
		it { should have_many :phone_sectors}
		it { should have_many :email_sectors}
		it { should have_many :organs}
		it { should have_many :electronic_portals}
	end
end 
