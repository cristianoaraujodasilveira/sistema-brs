require 'rails_helper'

RSpec.describe VisitsReport, type: :model do
  it 'has a valid factory' do
		expect(create :visits_report).to be_valid
	end

	describe 'Validations' do
		
		it { should validate_presence_of :date_and_time }
		it { should validate_presence_of :responsible_name }
		it { should validate_presence_of :phone }
		it { should validate_presence_of :email }
		it { should validate_presence_of :cnpj }
		it { should validate_presence_of :zipcode }
		it { should validate_presence_of :address }
		it { should validate_presence_of :district }
		it { should validate_presence_of :number }
		it { should validate_presence_of :state_id }
		it { should validate_presence_of :city_id }
		it { should validate_presence_of :scale_id }
		it { should validate_presence_of :fantasy_name }
		it { should validate_presence_of :user_id }

	end

	describe 'Relations' do
		it { should belong_to :client }
		it { should belong_to :state }
		it { should belong_to :city }
		it { should belong_to :scale }
		it { should belong_to :user }
	end
end
