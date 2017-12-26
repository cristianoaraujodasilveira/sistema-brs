require 'rails_helper'

RSpec.describe PhoneSector, type: :model do
	it 'has a valid factory' do
		expect(create :phone_sector).to be_valid
	end

	it { should validate_presence_of :phone }
	it { should validate_presence_of :extension }
	it { should validate_presence_of :sector_id }
	it { should belong_to :sector }
end 
