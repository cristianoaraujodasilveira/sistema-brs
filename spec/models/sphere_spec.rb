require 'rails_helper'

RSpec.describe Sphere, type: :model do
  it 'has a valid factory' do
		expect(create :sphere).to be_valid
	end
	it { should validate_presence_of :name }
	it { should have_many :organs }
end
 