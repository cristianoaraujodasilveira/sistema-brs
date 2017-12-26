require 'rails_helper'

RSpec.describe Observation, type: :model do
	it 'has a valid factory' do
		expect(create :observation).to be_valid
	end
	it { should belong_to :user }
end
