require 'rails_helper'

RSpec.describe ClientSegment, type: :model do
	it 'has a valid factory' do
		expect(create :client_segment).to be_valid
	end

	it { should belong_to :client }
	it { should have_many :words_keys }
end
