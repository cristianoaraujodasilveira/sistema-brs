require 'rails_helper'

RSpec.describe SubfolderDocument, type: :model do
	it 'has a valid factory' do
		expect(create :subfolder_document).to be_valid
	end
end
