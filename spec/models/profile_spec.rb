require 'rails_helper'

RSpec.describe Profile, type: :model do
	it 'has a valid factory' do
		expect(create :profile).to be_valid
	end
	it { should validate_presence_of :name }
	it { should have_many :users }
end
