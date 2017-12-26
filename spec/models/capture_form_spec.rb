require 'rails_helper'

RSpec.describe CaptureForm, type: :model do
	it 'has a valid factory' do
		expect(create :capture_form).to be_valid
	end
end
