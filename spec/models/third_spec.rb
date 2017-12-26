require 'rails_helper'

RSpec.describe Third, type: :model do
	it 'has a valid factory' do
		expect(create :third).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :register_number }

		context 'Motoboys' do 
			before { allow(subject).to receive(:third_type_id) { 3 } }
			it { should validate_presence_of :name }
			it { should validate_presence_of :rg }
			it { should validate_presence_of :cpf }
		end

		context 'Diligents' do 
			before { allow(subject).to receive(:third_type_id) { 5 } }
			it { should validate_presence_of :name }
			it { should validate_presence_of :rg }
			it { should validate_presence_of :cpf }
			it { should validate_presence_of :diligent_profile_id }
		end
	end

	describe 'Relations' do
		it { should belong_to :diligent_profile }
		it { should belong_to :third_type }
		it { should have_many :emails }
		it { should have_many :phones }
		it { should have_one :responsible }
		it { should have_one :address }
		it { should have_many :attachments }
		it { should have_many :observations }
	end
end
