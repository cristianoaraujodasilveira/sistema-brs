require 'rails_helper'

RSpec.describe CalendarColor, type: :model do
	it 'has a valid factory' do
		expect(create :calendar_color).to be_valid
	end
end
