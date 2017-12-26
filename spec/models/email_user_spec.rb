require 'rails_helper'

RSpec.describe EmailUser, type: :model do
  it 'has a valid factory' do
		expect(create :email_user).to be_valid
	end

	it { should validate_presence_of :email }
	it { should validate_presence_of :user_id }
	it { should belong_to :user }
end
