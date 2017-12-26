require 'rails_helper'

RSpec.describe ClientDocumentStatus, type: :model do
  it 'has a valid factory' do
		expect(create :client_document_status).to be_valid
	end
end
