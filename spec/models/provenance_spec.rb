require 'rails_helper'

RSpec.describe Provenance, type: :model do
	it 'has a valid factory' do
		expect(create :provenance).to be_valid
	end
end
