require 'rails_helper'

RSpec.describe PieceProcessFile, type: :model do
	it 'has a valid factory' do
		expect(create :piece_process_file).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :folder_name }
	end

	describe 'Relations' do
		it { should belong_to :piece }
		it { should have_many :attachments }
	end
end
