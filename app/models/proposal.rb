class Proposal < ActiveRecord::Base
	audited

	attr_accessor :skip_validate

	belongs_to :client
	belongs_to :proposal_situation
	belongs_to :user
	belongs_to :visits_report

	has_and_belongs_to_many :users, :validate => false
	accepts_nested_attributes_for :users, :reject_if => proc { |a| a['id'].blank? }
	# validate :require_at_least_one_responsible

	has_many :contracts, dependent: :destroy

	has_many :clients

	has_many :monthly_values, dependent: :destroy
	accepts_nested_attributes_for :monthly_values, allow_destroy: true, :reject_if => proc { |attrs| attrs['percentual_discounts'].blank?}

	has_many :upload_proposals, dependent: :destroy
	accepts_nested_attributes_for :upload_proposals, allow_destroy: true, :reject_if => proc { |attrs| attrs['file'].blank?}

	has_many :proposal_historics, dependent: :destroy
	accepts_nested_attributes_for :proposal_historics, allow_destroy: true, :reject_if => proc { |attrs| attrs['comment'].blank?}

	validates_presence_of :visits_report_id,
	:social_name,
	:cnpj,
	:fantasy_name,
	:proposal_situation_id,
	:proposed_value,
	:minimum_value,
	:proposed_percentage,
	:user_id, if: Proc.new { |proposal| proposal.skip_validate != true}

	# Mensagens de notificações
	def self.notification_new_proposal(proposal, user)
		return 'Proposta <b>'+Proposal.get_text_proposal(proposal)+'</b> cadastrada por <b>'+user.name+'</b>'
	end

	def self.notification_edit_proposal(proposal, user)
		return 'Proposta <b>'+Proposal.get_text_proposal(proposal)+'</b> editada por <b>'+user.name+'</b>'
	end

	def self.notification_delete_proposal(proposal, user)
		return 'Proposta <b>'+Proposal.get_text_proposal(proposal)+'</b> removida por <b>'+user.name+'</b>'
	end

	def self.get_text_proposal(proposal)
		if proposal.visits_report && proposal.visits_report.proposal_text
			text = proposal.visits_report.proposal_text
		elsif proposal.title != nil
			text = proposal.title
		end
	end

	private

	def require_at_least_one_responsible
		errors.add(:base,"Deve haver ao menos 1 intermediador") if self.users.blank?
	end
end
