require 'rails_helper'

RSpec.describe HonoraryForm, type: :model do
	it 'has a valid factory' do
		expect(create :honorary_form).to be_valid
	end

	it { should validate_presence_of :name }
end
