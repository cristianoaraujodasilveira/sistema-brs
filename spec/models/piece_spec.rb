require 'rails_helper'

RSpec.describe Piece, type: :model do
	it 'has a valid factory' do
		expect(create :piece).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :piece_name_id }
		it { should validate_presence_of :judicial_type_id }
		it { should validate_presence_of :client_id }
		it { should validate_presence_of :organ_id }
		it { should validate_presence_of :shipping_type_id }
		it { should validate_presence_of :piece_situation_id }
		it { should validate_presence_of :number }
		it { should validate_presence_of :process }
		it { should validate_presence_of :modalidate_id }
		it { should validate_presence_of :initial_date }
		it { should validate_presence_of :deadline }
	end

	describe 'Relations' do
		it { should belong_to :piece_name }
		it { should belong_to :judicial_type }
		it { should belong_to :piece_result }
		it { should belong_to :client }
		it { should belong_to :organ }
		it { should belong_to :shipping_type }
		it { should belong_to :piece_situation }
		it { should belong_to :modalidate }
		it { should have_many :attachments }
		it { should have_many :observations }
		it { should have_many :piece_process_files }
		it { should have_many :piece_historic_situations }
		it { should have_and_belong_to_many :lawyers }
	end
end
