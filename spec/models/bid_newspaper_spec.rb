require 'rails_helper'

RSpec.describe BidNewspaper, type: :model do
	it 'has a valid factory' do
		expect(create :bid_newspaper).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :client_id }
		it { should validate_presence_of :user_id }
		it { should validate_presence_of :initial_date }
		it { should validate_presence_of :final_date }
		it { should validate_presence_of :social_name }
		it { should validate_presence_of :cnpj }
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :client }
		it { should have_many :responsibles }
		it { should have_many :observations }
	end
end
