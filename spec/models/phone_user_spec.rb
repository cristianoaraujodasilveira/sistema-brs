require 'rails_helper'

RSpec.describe PhoneUser, type: :model do
  it 'has a valid factory' do
		expect(create :phone_user).to be_valid
	end

	it { should validate_presence_of :phone }
	it { should validate_presence_of :user_id }
	it { should belong_to :user }
end
