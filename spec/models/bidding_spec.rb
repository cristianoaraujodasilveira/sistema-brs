require 'rails_helper'

RSpec.describe Bidding, type: :model do
	it 'has a valid factory' do
		expect(create :bidding).to be_valid
	end

	describe 'Relations' do
		it { should have_many :observations }
		it { should have_many :attachments }

		it { should have_and_belong_to_many(:good_habits).class_name("GoodHabit") }
		it { should have_and_belong_to_many(:accreditation_presentials).class_name("AccreditationPresential") }
		it { should have_and_belong_to_many(:habilitations).class_name("Habilitation") }
		it { should have_and_belong_to_many(:participation_users).class_name("User") }

		it { should have_many :bidding_responsibles }
		it { should have_many :bidding_proposals }
		it { should have_many :bidding_resources }
	end

	context 'Validations' do
		context 'Step Capture' do
			before { allow(subject).to receive(:step) { 1 } }
			it { should validate_presence_of :catch_user_id }
			it { should validate_presence_of :catch_date_catch }
			it { should validate_presence_of :catch_client_id }
			it { should validate_presence_of :catch_organ_id }
			it { should validate_presence_of :catch_capture_form_id }
			it { should validate_presence_of :catch_modalidate_id }
			it { should validate_presence_of :catch_number }
			it { should validate_presence_of :catch_limit_date }
			it { should validate_presence_of :catch_competition_date }

			context 'Capture Form Others' do 
				before { allow(subject).to receive(:catch_capture_form_id) { 7 } }
				it { should validate_presence_of :catch_other_capture_form }
				it { should validate_presence_of :catch_cost }
			end

			context 'Capture Form Bid Newspaper' do 
				before { allow(subject).to receive(:catch_capture_form_id) { 3 } }
				it { should validate_presence_of :catch_bid_newspaper_id }
			end

			context 'Capture Form Bid Newspaper' do 
				before { allow(subject).to receive(:catch_capture_form_id) { 1 } }
				it { should validate_presence_of :catch_capture_form_presencial_id }
				it { should validate_presence_of :catch_cost }
			end

			context 'Capture Form Bid Newspaper' do 
				before { allow(subject).to receive(:catch_capture_form_id) { 6 } }
				it { should validate_presence_of :catch_solicitation_date_organ }
				it { should validate_presence_of :catch_limit_date_organ }
			end
		end

		context 'Step Read' do
			before { allow(subject).to receive(:step) { 2 } }
			it { should validate_presence_of :read_user_id }
			it { should validate_presence_of :read_date_read }
			it { should validate_presence_of :read_judgment_form_id }
			it { should validate_presence_of :read_bidding_read_delivery_id }
			it { should validate_presence_of :read_bidding_read_delivery_deadline }

			context 'Sample' do 
				before { allow(subject).to receive(:read_sample) { true } }
				it { should validate_presence_of :read_delivery_time }
			end

			context 'Survey' do 
				before { allow(subject).to receive(:read_survey) { true } }
				it { should validate_presence_of :read_deadline }
			end

			context 'Judgemt Form Another' do 
				before { allow(subject).to receive(:read_judgment_form_id) { 15 } }
				it { should validate_presence_of :read_other_judgment_form }
			end

		end
	end
end
