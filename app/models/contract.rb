class Contract < ActiveRecord::Base
	audited

	attr_accessor :step, :subject, :email, :cc, :cco, :message
	has_and_belongs_to_many :users, :validate => false
	
	belongs_to :client
	belongs_to :proposal
	belongs_to :user

	belongs_to :comercial_agent, :class_name => 'User'
	belongs_to :intermediary, :class_name => 'User'

	# validate :require_at_least_one_responsible, if: Proc.new { |contract| contract.step == 1 || contract.step == "1" }

	has_many :contract_responsibles, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :contract_responsibles, allow_destroy: true
	validates_associated :contract_responsibles, if: Proc.new { |contract| contract.step == 1 || contract.step == "1" }

	has_many :contract_responsible_financials, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :contract_responsible_financials, allow_destroy: true
	validates_associated :contract_responsible_financials, if: Proc.new { |contract| contract.step == 2 || contract.step == "2" }

	has_many :contract_payments, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :contract_payments, allow_destroy: true
	validates_associated :contract_payments, if: Proc.new { |contract| contract.step == 2 || contract.step == "2" }

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	validates_presence_of :proposal_id, if: Proc.new { |contract| contract.step == 1 || contract.step == "1" }

	def get_phones
		text = ""
		if self.contract_responsibles && self.contract_responsibles.length > 0
			self.contract_responsibles.each do |cr|
				if cr.phone_users && cr.phone_users.length > 0
					cr.phone_users.each do |phone|
						text += phone.phone + ", "
					end
				end
			end
		end
		return text
	end

	def get_social_name
		if self.proposal
			return self.proposal.social_name
		else
			return "Sem razão social"
		end
	end

	# Mensagens de notificações
	def self.notification_new_contract(contract, user)
		return 'Contrato <b>'+Contract.get_text_contract(contract)+'</b> cadastrado por <b>'+user.name+'</b>'
	end

	def self.notification_edit_contract(contract, user)
		return 'Contrato <b>'+Contract.get_text_contract(contract)+'</b> editado por <b>'+user.name+'</b>'
	end

	def self.notification_delete_contract(contract, user)
		return 'Contrato <b>'+Contract.get_text_contract(contract)+'</b> removido por <b>'+user.name+'</b>'
	end

	def self.get_text_contract(contract)
		if contract && contract.proposal
			return contract.proposal.social_name
		end
		return contract.title
	end

	# Rotina de atualização dos descontos nos contratos
	def self.update_values_contracts
		contracts = Contract.all
		contracts.each do |contract|
			update_monthly_payment(contract)
			update_comission(contract)
		end
	end

	def self.update_monthly_payment(contract)
		discount = true
		if contract.monthly_discount && contract.monthly_discount.length > 0
			if contract.monthly_initial_date && contract.monthly_final_date
				if !Time.zone.today.between?(contract.monthly_initial_date, contract.monthly_final_date)
					discount = false
				end
			elsif contract.monthly_initial_date
				if contract.monthly_initial_date > Time.zone.today
					discount = false
				end
			elsif contract.monthly_final_date
				if contract.monthly_final_date < Time.zone.today
					discount = false
				end
			else
				discount = false
			end
			if discount
				discount = return_string_like_number(contract.monthly_discount)
				value = return_string_like_number(contract.monthly_fixed_payment)
				value_calculed = value.to_f - discount.to_f
				value_formatted = return_number_like_string(value_calculed.to_s, 1)
				contract.update_column(:monthly_payment, value_formatted)
			end
		else
			discount = false
		end
		if !discount
			contract.update_column(:monthly_payment, contract.monthly_fixed_payment)
		end
	end

	def self.update_comission(contract)
		discount = true
		if contract.comission_discount && contract.comission_discount.length > 0
			if contract.comission_initial_date && contract.comission_final_date
				if !Time.zone.today.between?(contract.comission_initial_date, contract.comission_final_date)
					discount = false
				end
			elsif contract.comission_initial_date
				if contract.comission_initial_date > Time.zone.today
					discount = false
				end
			elsif contract.comission_final_date
				if contract.comission_final_date < Time.zone.today
					discount = false
				end
			else
				discount = false
			end
			if discount
				discount = return_string_like_number(contract.comission_discount)
				value = return_string_like_number(contract.comission_fixed_payment)
				value_calculed = value.to_f - discount.to_f
				value_formatted = return_number_like_string(value_calculed.to_s, 2)
				contract.update_column(:comission_payment, value_formatted)
			end
		else
			discount = false
		end
		if !discount
			contract.update_column(:comission_payment, contract.comission_fixed_payment)
		end
	end

	def self.return_string_like_number(value)
		if value 
			value = value.gsub('R$ ','')
			value = value.gsub('%','')
			value = value.gsub('.','')
			value = value.gsub(',','.')
		end
		return value
	end

	def self.return_number_like_string(value, type)
		if value 
			temp = value.to_s.split('.')
			if temp[0] && temp[0].length == 1
				initial = '0'+temp[0]
			else
				initial = temp[0]
			end
			if temp[1] && temp[1].length == 1
				decimal = temp[1]+'0'
			elsif temp[1]
				decimal = temp[1]
			else
				decimal = '0'
			end
			if type == 1
				value = 'R$ '+initial+','+decimal
			elsif type == 2
				value = initial+','+decimal+'%'
			end
		end
		return value
	end

	private

	def require_at_least_one_responsible
		errors.add(:base,"Deve haver ao menos 1 intermediador") if self.users.blank?
	end
end
