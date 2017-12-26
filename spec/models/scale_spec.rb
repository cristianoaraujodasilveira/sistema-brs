require 'rails_helper'

RSpec.describe Scale, type: :model do
  it 'has a valid factory' do
		expect(create :scale).to be_valid
	end
	it { should validate_presence_of :name }
	it { should have_many :visits_reports }
end
