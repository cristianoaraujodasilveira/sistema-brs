require 'rails_helper'

RSpec.describe ElectronicPortal, type: :model do
	it 'has a valid factory' do
		expect(create :electronic_portal).to be_valid
	end

	it { should validate_presence_of :value }
	it { should belong_to :organ }
end
