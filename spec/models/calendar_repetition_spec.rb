require 'rails_helper'

RSpec.describe CalendarRepetition, type: :model do
	it 'has a valid factory' do
		expect(create :calendar_repetition).to be_valid
	end
end
