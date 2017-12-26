require 'rails_helper'

RSpec.describe WordsKey, type: :model do
	it 'has a valid factory' do
		expect(create :words_key).to be_valid
	end
	it { should belong_to :client_segment }
end
