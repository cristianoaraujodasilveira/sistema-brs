require 'rails_helper'

RSpec.describe Communication, type: :model do
	it 'has a valid factory' do
		expect(create :bidding).to be_valid
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :communication_status }
		it { should belong_to :department_notified }
		it { should belong_to :client }
		it { should belong_to :organ }
		it { should belong_to :modalidate }
		it { should have_many :attachments }
		it { should have_many :observations }
		it { should have_and_belong_to_many(:communications_users).class_name('User') }
	end

	context 'Validations' do
		it { should validate_presence_of :user_id }
		it { should validate_presence_of :subject }
		it { should validate_presence_of :description }
	end
end
