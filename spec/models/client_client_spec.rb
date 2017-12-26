require 'rails_helper'

RSpec.describe ClientClient, type: :model do
	it 'has a valid factory' do
		expect(create :client_client).to be_valid
	end

	it { should belong_to :client }
end
