require 'rails_helper'

RSpec.describe Modalidate, type: :model do
	it 'has a valid factory' do
		expect(create :modalidate).to be_valid
	end
end
