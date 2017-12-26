require 'rails_helper'

RSpec.describe CaptureFormPresencial, type: :model do
	it 'has a valid factory' do
		expect(create :capture_form_presencial).to be_valid
	end
end
