require 'rails_helper'

RSpec.describe BiddingProposal, type: :model do
	it 'has a valid factory' do
		expect(create :bidding_proposal).to be_valid
	end

	describe 'Relations' do

		it { should belong_to :bidding }
		it { should belong_to :price_offer }
		it { should belong_to :registration_form }
		it { should belong_to :judgment_form }
		it { should belong_to :partner_rank }
		it { should belong_to :participation_result }
		it { should belong_to :competition_status }
		it { should belong_to :unit }
		it { should belong_to :bidder_status }
		it { should belong_to :provenance }
		it { should belong_to :country }

		it { should have_one :address }
		it { should have_many :phones }
		it { should have_many :emails }
	end
end
