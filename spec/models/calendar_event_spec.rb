require 'rails_helper'

RSpec.describe CalendarEvent, type: :model do
	it 'has a valid factory' do
		expect(create :calendar_event).to be_valid
	end

	it { should belong_to :entity_class }
	it { should belong_to :user }
	it { should belong_to :calendar_type_event }
	it { should belong_to :state }
	it { should belong_to :city }
	it { should belong_to :calendar_repetition }
	it { should have_and_belong_to_many :weekdays }

	it { should validate_presence_of :user_id }

end
