require 'rails_helper'

RSpec.describe RegistrationForm, type: :model do
	it 'has a valid factory' do
		expect(create :registration_form).to be_valid
	end
end
