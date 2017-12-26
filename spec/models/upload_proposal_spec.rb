require 'rails_helper'

RSpec.describe UploadProposal, type: :model do
  it 'has a valid factory' do
		expect(create :upload_proposal).to be_valid
	end
	
	it { should belong_to :proposal }
	it { should validate_presence_of :file }
	
end
