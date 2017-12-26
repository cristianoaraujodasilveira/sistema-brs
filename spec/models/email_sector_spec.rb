require 'rails_helper'

RSpec.describe EmailSector, type: :model do
	it 'has a valid factory' do
		expect(create :email_sector).to be_valid
	end

	it { should validate_presence_of :email }
	it { should validate_presence_of :sector_id }
	it { should belong_to :sector }
end 
