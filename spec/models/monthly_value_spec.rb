require 'rails_helper'

RSpec.describe MonthlyValue, type: :model do
  it 'has a valid factory' do
		expect(create :monthly_value).to be_valid
	end

	it { should belong_to :proposal }
end
