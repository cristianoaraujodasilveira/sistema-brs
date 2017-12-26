require 'rails_helper'

RSpec.describe Library, type: :model do
	it 'has a valid factory' do
		expect(create :library).to be_valid
	end

	describe 'Relations' do
		it { should have_many :attachments }
		it { should have_many :words_keys }
		it { should belong_to :library_category }
		it { should belong_to :state }
		it { should belong_to :city }
	end

	context 'Validations' do
		it { should validate_presence_of :library_category_id }
		it { should validate_presence_of :title }
		it { should validate_presence_of :author_name }
	end
end
