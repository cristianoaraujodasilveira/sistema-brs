require 'rails_helper'

RSpec.describe ClientDocumentType, type: :model do
  it 'has a valid factory' do
		expect(create :client_document_type).to be_valid
	end
end
