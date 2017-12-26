class Communication < ActiveRecord::Base
	audited
	
	belongs_to :user
	belongs_to :communication_status
	belongs_to :department_notified
	belongs_to :client
	belongs_to :organ
	belongs_to :modalidate

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	has_and_belongs_to_many :communications_users, :validate => false, dependent: :destroy, join_table: 'communications_users', class_name: 'User'

	validates_presence_of :user_id, :subject, :description

	validate :require_at_least_one_receiver

	def get_id_last_observation
		last_id = 0
		self.observations.each do |ob|
			if ob.id != nil
				last_id = ob.id
			end
		end
		return last_id
	end

	# Mensagens de notificações
	def self.notification_new_communication(communication, user)
		return 'Comunicado interno <b>'+communication.subject+'</b> vinculado a você cadastrado por <b>'+user.name+'</b>'
	end

	def self.notification_edit_communication(communication, user)
		return 'Comunicado interno <b>'+communication.subject+'</b> editado por <b>'+user.name+'</b>'
	end

	def self.notification_delete_communication(communication, user)
		return 'Comunicado interno <b>'+communication.subject+'</b> removido por <b>'+user.name+'</b>'
	end

	def self.notification_end_communication(communication, user)
		return 'Comunicado interno <b>'+communication.subject+'</b> finalizado por <b>'+user.name+'</b>'
	end

	def self.notification_reopen_communication(communication, user)
		return 'Comunicado interno <b>'+communication.subject+'</b> reaberto por <b>'+user.name+'</b>'
	end

	private

	def require_at_least_one_receiver
		errors.add(:base,"Deve haver ao menos 1 receptor selecionado") if self.communications_users.blank?
	end
end
