require 'rails_helper'

RSpec.describe Financial, type: :model do
	it 'has a valid factory' do
		expect(create :financial).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :client_id }
	end

	describe 'Relations' do
		it { should belong_to :client }
		it { should belong_to :contract }
	end
end
