require 'rails_helper'

RSpec.describe Sector, type: :model do
	it 'has a valid factory' do
		expect(create :sector).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :responsible_name }
	end

	describe 'Relations' do
		it { should belong_to :organ }
		it { should have_many :email_sectors }
		it { should have_many :phone_sectors }
	end 
end
