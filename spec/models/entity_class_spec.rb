require 'rails_helper'

RSpec.describe EntityClass, type: :model do
	it 'has a valid factory' do
		expect(create :entity_class).to be_valid
	end

	it { should validate_presence_of :name }
	it { should have_many :entity_class_responsibles }
end
