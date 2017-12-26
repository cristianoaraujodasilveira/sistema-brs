require 'rails_helper'

RSpec.describe ClientDocument, type: :model do
	it 'has a valid factory' do
		expect(create :client_document).to be_valid
	end

	it { should belong_to :client }
	it { should belong_to :client_document_status }
	it { should belong_to :client_document_type }
	it { should belong_to :client_document_notification }
	it { should belong_to :subfolder_document }
end
