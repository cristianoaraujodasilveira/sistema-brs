require 'rails_helper'

RSpec.describe ProcessStatus, type: :model do
	it 'has a valid factory' do
		expect(create :process_status).to be_valid
	end
end
