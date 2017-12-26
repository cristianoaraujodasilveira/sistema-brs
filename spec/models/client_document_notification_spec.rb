require 'rails_helper'

RSpec.describe ClientDocumentNotification, type: :model do
	it 'has a valid factory' do
		expect(create :client_document_notification).to be_valid
	end
end
