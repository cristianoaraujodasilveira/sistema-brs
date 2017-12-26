class Bidding < ActiveRecord::Base
	audited

	attr_accessor :step
	attr_accessor :good_habit_name_read, :accreditation_presential_name_read, :habilitation_name_read
	attr_accessor :good_habit_name_participation, :accreditation_presential_name_participation, :habilitation_name_participation
	
	belongs_to :catch_user, :class_name => 'User'
	belongs_to :catch_client, :class_name => 'Client'
	belongs_to :catch_organ, :class_name => 'Organ'
	belongs_to :catch_capture_form, :class_name => 'CaptureForm'
	belongs_to :catch_bid_newspaper, :class_name => 'BidNewspaper'
	belongs_to :catch_capture_form_presencial, :class_name => 'CaptureFormPresencial'
	belongs_to :catch_modalidate, :class_name => 'Modalidate'
	belongs_to :catch_portal, :class_name => 'Portal'
	belongs_to :read_user, :class_name => 'User'
	belongs_to :read_judgment_form, :class_name => 'JudgmentForm'
	belongs_to :read_bidding_read_delivery, :class_name => 'BiddingReadDelivery'
	belongs_to :participation_partner_participation, :class_name => 'PartnerParticipation'
	belongs_to :participation_process_status, :class_name => 'ProcessStatus'
	belongs_to :participation_process_location, :class_name => 'ProcessLocation'
	belongs_to :organ_ride, :class_name => 'Organ'

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	has_and_belongs_to_many :good_habits, join_table: :biddings_good_habits, class_name: "GoodHabit"
	has_and_belongs_to_many :accreditation_presentials, join_table: :biddings_accreditation_presentials, class_name: "AccreditationPresential"
	has_and_belongs_to_many :habilitations, join_table: :biddings_habilitations, class_name: "Habilitation"

	has_many :bidding_responsibles, dependent: :destroy
	accepts_nested_attributes_for :bidding_responsibles, allow_destroy: true, :reject_if => proc { |attrs| attrs[:user_id].blank? && attrs[:initial_date].blank? && attrs[:final_date].blank? }

	has_many :bidding_proposals, dependent: :destroy
	accepts_nested_attributes_for :bidding_proposals, allow_destroy: true

	has_many :bidding_resources, dependent: :destroy
	accepts_nested_attributes_for :bidding_resources, allow_destroy: true

	has_many :efforts, dependent: :destroy
	accepts_nested_attributes_for :efforts, allow_destroy: true, :reject_if => proc { |attrs| attrs[:value].blank? }

	has_many :financial_invoices, dependent: :destroy
	accepts_nested_attributes_for :financial_invoices, allow_destroy: true, :reject_if => proc { |attrs| attrs[:total_value].blank? }

	has_and_belongs_to_many :participation_users, :validate => false, join_table: :biddings_users, class_name: "User"

	has_one :address, :validate => false, :as => :addresstable, dependent: :destroy
	accepts_nested_attributes_for :address

	# step capture
	validates_presence_of :catch_user_id,
	:catch_date_catch,
	:catch_client_id,
	:catch_organ_id,
	:catch_capture_form_id,
	:catch_modalidate_id,
	:catch_number,
	:catch_limit_date,
	:catch_competition_date, if: Proc.new { |bidding| bidding.step == 1 || bidding.step == "1" }
	validates_presence_of :catch_other_capture_form,
	:catch_cost, if: Proc.new { |bidding| (bidding.step == 1 || bidding.step == "1") && bidding.catch_capture_form_id == 7 }
	validates_presence_of :catch_bid_newspaper_id, if: Proc.new { |bidding| (bidding.step == 1 || bidding.step == "1") && bidding.catch_capture_form_id == 3 }
	validates_presence_of :catch_capture_form_presencial_id,
	:catch_cost, if: Proc.new { |bidding| (bidding.step == 1 || bidding.step == "1") && bidding.catch_capture_form_id == 1 }
	validates_presence_of :catch_solicitation_date_organ,
	:catch_limit_date_organ, if: Proc.new { |bidding| (bidding.step == 1 || bidding.step == "1") && bidding.catch_capture_form_id == 6 }
	validate :validate_attachments_capture_step, if: Proc.new { |bidding| (bidding.step == 1 || bidding.step == "1")}

	# step read
	validates_presence_of :read_user_id,
	:read_date_read,
	:read_judgment_form_id,
	:read_bidding_read_delivery_id,
	:read_bidding_read_delivery_deadline, if: Proc.new { |bidding| bidding.step == 2 || bidding.step == "2" }
	validates_presence_of :read_delivery_time, if: Proc.new { |bidding| (bidding.step == 2 || bidding.step == "2") && bidding.read_sample == true }
	validates_presence_of :read_deadline, if: Proc.new { |bidding| (bidding.step == 2 || bidding.step == "2") && bidding.read_survey == true }
	validates_presence_of :read_other_judgment_form, if: Proc.new { |bidding| (bidding.step == 2 || bidding.step == "2") && bidding.read_judgment_form_id == 15 }

	def get_fantasy_name
		if self.catch_client
			return self.catch_client.fantasy_name
		else
			return "Sem razão social"
		end
	end

	# Mensagens de notificações
	def self.notification_bidding_catch(bidding, user)
		return 'Captura de licitação de ID <b>'+bidding.id.to_s+'</b> editada por <b>'+user.name+'</b>'
	end

	def self.notification_bidding_read(bidding, user)
		return 'Leitura de licitação de ID <b>'+bidding.id.to_s+'</b> editada por <b>'+user.name+'</b>'
	end

	def self.notification_bidding_participation(bidding, user)
		return 'Participação de licitação de ID <b>'+bidding.id.to_s+'</b> editada por <b>'+user.name+'</b>'
	end

	private

	def validate_attachments_capture_step
		errors.add(:catch_attachments_edital, "Necessário ao menos 1 arquivo") if self.attachments.select{|item| item[:attachment_type] == 2}.length == 0
	end
end
