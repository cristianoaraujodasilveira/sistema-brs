require 'rails_helper'

RSpec.describe FinancialThird, type: :model do
	it 'has a valid factory' do
		expect(create :financial_third).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :financial_id }
		it { should validate_presence_of :third_type_id }
		it { should validate_presence_of :financial_third_service_id }
		it { should validate_presence_of :quantity }
		it { should validate_presence_of :value }
		it { should validate_presence_of :date }
	end

	describe 'Relations' do
		it { should belong_to :financial_third_service }
		it { should belong_to :financial }
		it { should belong_to :third_type }
		it { should belong_to :third }
		it { should belong_to :lawyer }
	end
end
