class BiddingProposal < ActiveRecord::Base
  audited

  belongs_to :bidding
  belongs_to :price_offer
  belongs_to :registration_form
  belongs_to :judgment_form
  belongs_to :partner_rank
  belongs_to :participation_result
  belongs_to :competition_status
  belongs_to :unit
  belongs_to :bidder_status
  belongs_to :provenance
  belongs_to :country

  has_one :address, :validate => false, :as => :addresstable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :phones, :as => :phonetable, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

  has_many :emails, :as => :emailtable, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

  def get_id_financial
    financial_id = nil
    if self && self.bidding && self.bidding.catch_client
      financial_id = Financial.where(:client_id => self.bidding.catch_client_id).first
    end
    return financial_id
  end

end