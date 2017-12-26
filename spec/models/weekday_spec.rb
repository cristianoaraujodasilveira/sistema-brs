require 'rails_helper'

RSpec.describe Weekday, type: :model do
	it 'has a valid factory' do
		expect(create :weekday).to be_valid
	end
	it { should have_and_belong_to_many :calendar_events }

end
