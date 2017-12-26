require 'rails_helper'

RSpec.describe Lawyer, type: :model do
	it 'has a valid factory' do
		expect(create :lawyer).to be_valid
	end

	describe 'Relations' do
		it { should have_many :addresses }
		it { should have_many :phones }
		it { should have_many :emails }
		it { should belong_to :lawyer_type }
		it { should belong_to :honorary_form }
		it { should belong_to :state }
		it { should belong_to :city }
	end

	context 'Validations' do
		it { should validate_presence_of :lawyer_type_id }
		it { should validate_presence_of :name }
		it { should validate_presence_of :created_date }
		it { should validate_presence_of :office }
		it { should validate_presence_of :cnpj }
		it { should validate_presence_of :cpf }
		it { should validate_presence_of :oab }
		it { should validate_presence_of :state_id }
		it { should validate_presence_of :city_id }
		it { should validate_presence_of :honorary_form_id }
		it { should validate_presence_of :honorary_value }
	end
end
