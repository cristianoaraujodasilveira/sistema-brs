require 'rails_helper'

RSpec.describe State, type: :model do
  it 'has a valid factory' do
		expect(create :state).to be_valid
	end

	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:acronym) }
	it { should have_many :cities }
	it { should have_many :users }
	it { should have_many :organs }
end
