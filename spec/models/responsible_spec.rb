require 'rails_helper'

RSpec.describe Responsible, type: :model do
	it 'has a valid factory' do
		expect(create :responsible).to be_valid
	end

	describe 'Relations' do
		it { should have_many :emails }
		it { should have_many :phones }
		it { should have_many :skypes }
	end
end
