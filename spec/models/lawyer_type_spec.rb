require 'rails_helper'

RSpec.describe LawyerType, type: :model do
	it 'has a valid factory' do
		expect(create :lawyer_type).to be_valid
	end

	it { should validate_presence_of :name }
end
