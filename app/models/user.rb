class User < ActiveRecord::Base
	audited
	acts_as_reader
	
	attr_accessor :skip_validate_password, :seed, :edit_pass

	scope :unblocked, -> do
		where.not(is_blocked: true).where.not(:id => 1)
	end

	scope :comercial_agent, -> do
		where(profile_id: 9)
	end

	scope :intermediary, -> do
		where(profile_id: 10)
	end

	scope :to_create_notification, lambda { |values| where('profile_id IN (?) AND is_blocked = 0', values) if values != nil && values != '' && values.length > 0 && values[0] != nil && values[0] != '' }
	
	scope :permission_commercial, lambda { |values| joins(:permission_profiles).where('profile_id IN (?) AND is_blocked = 0', values) if values != nil && values != '' && values.length > 0 && values[0] != nil && values[0] != '' }

	scope :permission_commercial, -> do
		joins(:permission_profiles).where(permission_profiles: { permission_profile_id: value }).first
	end

	has_many :calendar_events, dependent: :destroy

	has_and_belongs_to_many :contracts, dependent: :destroy
	has_and_belongs_to_many :calendar_events, dependent: :destroy

	belongs_to :state
	belongs_to :city
	belongs_to :office_state, :class_name => 'State'
	belongs_to :office_city, :class_name => 'City'
	belongs_to :profile
	belongs_to :calendar_color

	has_many :observations, dependent: :destroy

	has_many :phone_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	has_many :visits_reports, dependent: :destroy

	has_and_belongs_to_many :proposals, dependent: :destroy

	has_and_belongs_to_many :clients
	
	has_and_belongs_to_many :permission_profiles

	has_secure_password
	validates_presence_of :password, if: Proc.new { |user| user.skip_validate_password != true}

	validates_presence_of :profile_id, 
	:name,
	:email,
	:zipcode,
	:address,
	:district,
	:number,
	:state_id,
	:city_id,
	:rg,
	:cpf,
	:calendar_color_id,
	:birth_date, if: Proc.new { |user| user.seed != true && user.edit_pass != true}

	validates :number, :numericality => {:only_integer => true}, if: Proc.new { |user| user.seed != true}

	validates_uniqueness_of :cpf, :rg, :email, :case_sensitive => false

	validates_email_format_of :email, :message => 'inválido', if: Proc.new { |user| user.seed != true}

	validate :require_at_least_one_phone, if: Proc.new { |user| user.seed != true}
	validate :require_at_least_one_email, if: Proc.new { |user| user.seed != true}

	def save_date_access
		self.update_attributes!(last_access: DateTime.now, audit_comment: "Login", seed: true, skip_validate_password: true)
		audit = self.audits.last
		audit.user_id = self.id
		audit.user_type = "User"
		audit.save
	end

	def save_date_logout
		self.update_attributes!(last_logout: DateTime.now, audit_comment: "Logout", seed: true, skip_validate_password: true)
		audit = self.audits.last
		audit.user_id = self.id
		audit.user_type = "User"
		audit.save
	end

	# Administrador
	def is_admin?
		return self != nil && (self.profile_id == 1 || self.profile_id == 7) ? true : false
	end

	# Comercial
	def is_commercial?
		return self != nil && (self.profile_id == 3) ? true : false
	end

	# Licitação
	def is_bidding?
		return self != nil && (self.profile_id == 4 || self.profile_id == 11 || self.profile_id == 15 || self.profile_id == 16 || self.profile_id == 17) ? true : false
	end

	# Licitação - Leitura
	def is_bidding_read?
		return self != nil && (self.profile_id == 4 || self.profile_id == 11 || self.profile_id == 16 || self.profile_id == 17) ? true : false
	end

	# Licitação - Participação
	def is_bidding_participation?
		return self != nil && (self.profile_id == 4 || self.profile_id == 11 || self.profile_id == 17) ? true : false
	end

	# Jurídico
	def is_juridical?
		return self != nil && (self.profile_id == 5 || self.profile_id == 12) ? true : false
	end

	# Financeiro
	def is_financial?
		return self != nil && (self.profile_id == 6 || self.profile_id == 13) ? true : false
	end

	# Parceiro
	def is_partner?
		return self != nil && (self.profile_id == 2) ? true : false
	end

	# Cadastros
	def is_register?
		return self != nil && (self.profile_id == 11 || self.profile_id == 15 || self.profile_id == 16 || self.profile_id == 17) ? true : false
	end

	def permission_commercial?
		return self != nil && (self.is_admin? || self.is_commercial? || self.permission_profiles.select{|item| item[:id] == 1}.length > 0 ) ? true : false
	end

	def permission_bidding?
		return self != nil && (self.is_admin? || self.is_bidding? || self.permission_profiles.select{|item| item[:id] == 2}.length > 0 ) ? true : false
	end

	def permission_juridical?
		return self != nil && (self.is_admin? || self.is_juridical? || self.permission_profiles.select{|item| item[:id] == 3}.length > 0 ) ? true : false
	end

	def permission_financial?
		return self != nil && (self.is_admin? || self.is_financial? || self.permission_profiles.select{|item| item[:id] == 4}.length > 0 ) ? true : false
	end

	def permission_partner?
		return self != nil && (self.is_admin? || self.is_partner? || self.permission_profiles.select{|item| item[:id] == 5}.length > 0 ) ? true : false
	end

	def permission_register?
		return self != nil && (self.is_admin? || self.is_register? || self.permission_profiles.select{|item| item[:id] == 6}.length > 0 ) ? true : false
	end

	def permission_report?
		return self != nil && (self.is_admin? || self.permission_profiles.select{|item| item[:id] == 7}.length > 0 ) ? true : false
	end

	def disabled_edit_read_bidding?
		return self != nil && (self.is_admin? || self.is_commercial? || self.is_bidding_read? || self.is_bidding_participation? ) ? false : true
	end

	def disabled_edit_participation_bidding?
		return self != nil && (self.is_admin? || self.is_commercial? || self.is_bidding_participation? ) ? false : true
	end

	# Mensagens de notificações
	def self.notification_new_user(user_1, user_2)
		return 'Usuário <b>'+user_1.name+'</b> cadastrado por <b>'+user_2.name+'</b>'
	end

	def self.notification_edit_user(user_1, user_2)
		return 'Usuário <b>'+user_1.name+'</b> editado por <b>'+user_2.name+'</b>'
	end

	def self.notification_delete_user(user_1, user_2)
		return 'Usuário <b>'+user_1.name+'</b> removido por <b>'+user_2.name+'</b>'
	end

	private

	def require_at_least_one_phone
		errors.add(:base,"Deve haver ao menos 1 telefone pessoal") if self.phone_users.blank?
	end

	def require_at_least_one_email
		errors.add(:base,"Deve haver ao menos 1 email pessoal") if self.email_users.blank?
	end

end
