require 'rails_helper'

RSpec.describe OfficialDiary, type: :model do
	it 'has a valid factory' do
		expect(create :official_diary).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :social_name }
		it { should validate_presence_of :cnpj }
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :sphere }
		it { should have_one :address }
		it { should have_many :responsibles }
		it { should have_many :observations }
	end
end
