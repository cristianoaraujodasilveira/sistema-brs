require 'rails_helper'

RSpec.describe Proposal, type: :model do
	it 'has a valid factory' do
		expect(create :proposal).to be_valid
	end

	describe 'Validations' do
		it { should validate_presence_of :proposal_situation_id }
		it { should validate_presence_of :proposed_value }
		it { should validate_presence_of :minimum_value }
		it { should validate_presence_of :proposed_percentage }
		it { should validate_presence_of :social_name }
	end

	describe 'Relations' do
		it { should belong_to :client }
		it { should belong_to :proposal_situation }
		it { should have_and_belong_to_many :users }
		it { should have_many :upload_proposals }
		it { should have_many :monthly_values }
		it { should have_many :proposal_historics }
		
	end
end
