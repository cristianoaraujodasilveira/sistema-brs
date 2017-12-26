require 'rails_helper'

RSpec.describe JudicialType, type: :model do
	it 'has a valid factory' do
		expect(create :judicial_type).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :name }
	end
end
