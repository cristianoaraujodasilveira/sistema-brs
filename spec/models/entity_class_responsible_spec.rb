require 'rails_helper'

RSpec.describe EntityClassResponsible, type: :model do
	it 'has a valid factory' do
		expect(create :entity_class_responsible).to be_valid
	end

	it { should validate_presence_of :name }
	it { should have_many :phone_users }
	it { should have_many :email_users }
	it { should belong_to :entity_class }
end
