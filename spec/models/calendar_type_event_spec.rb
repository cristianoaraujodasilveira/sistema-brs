require 'rails_helper'

RSpec.describe CalendarTypeEvent, type: :model do
	it 'has a valid factory' do
		expect(create :calendar_type_event).to be_valid
	end
end
