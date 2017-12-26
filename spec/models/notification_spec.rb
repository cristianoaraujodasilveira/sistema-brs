require 'rails_helper'

RSpec.describe Notification, type: :model do
	it 'has a valid factory' do
		expect(create :notification).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :text }
		it { should validate_presence_of :action_notification_id }
		it { should validate_presence_of :area_notification_id }
	end

	describe 'Relations' do
		it { should belong_to :action_notification }
		it { should belong_to :area_notification }
	end
end
