require 'rails_helper'

RSpec.describe GoodHabit, type: :model do
	it 'has a valid factory' do
		expect(create :judgment_form).to be_valid
	end
end
