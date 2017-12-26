require 'rails_helper'

RSpec.describe City, type: :model do
  it 'has a valid factory' do
		expect(create :city).to be_valid
	end

	it { should validate_presence_of :name }
	it { should validate_presence_of :state_id }
	it { should belong_to :state }
	it { should have_many :users }
	it { should have_many :organs }
end
