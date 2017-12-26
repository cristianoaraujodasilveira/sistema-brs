require 'rails_helper'

RSpec.describe LibraryCategory, type: :model do
	it 'has a valid factory' do
		expect(create :library_category).to be_valid
	end

	describe 'Validations' do 
		it { should validate_presence_of :name }
	end
end
