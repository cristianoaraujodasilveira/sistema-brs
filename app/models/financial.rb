class Financial < ActiveRecord::Base
	audited
	
	belongs_to :client
	accepts_nested_attributes_for :client

	belongs_to :contract
	accepts_nested_attributes_for :contract

	validates_presence_of :client_id

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	has_many :financial_thirds, dependent: :destroy
	accepts_nested_attributes_for :financial_thirds, allow_destroy: true, :reject_if => proc { |attrs| attrs[:third_type_id].blank? || attrs[:financial_third_service_id].blank? || attrs[:quantity].blank?  || attrs[:value].blank?  }

	has_many :financial_tickets, dependent: :destroy
	accepts_nested_attributes_for :financial_tickets, allow_destroy: true, :reject_if => proc { |attrs| attrs[:due_date].blank? }

	def get_id_last_observation
		last_id = 0
		self.observations.each do |ob|
			if ob.id != nil
				last_id = ob.id
			end
		end
		return last_id
	end

	def hidden_thirds(third_type)
		if !third_type || third_type.id == 4
			return true
		end
		return false
	end

	def hidden_lawyers(third_type)
		if !third_type || third_type.id != 4
			return true
		end
		return false
	end

	def get_comission_brs_by_period
		brs_comission_final = 0
		if self && self.client && self.client.biddings.length > 0
			contract = Contract.find self.contract.id
			self.client.biddings.each do |bidding|
				bidding_proposals = bidding.bidding_proposals.select{|item| item[:participation_result_id] == 1 && (item[:competition_status_id] == 2 || item[:competition_status_id] == 3 || item[:competition_status_id] == 4 )}
				bidding_proposals.each do |proposal|
					value = Contract.return_string_like_number(proposal.brs_comission_final).to_f
					if value
						brs_comission_final = brs_comission_final + value
					end
				end
			end
		end
		return Contract.return_number_like_string(brs_comission_final,1)
	end

	def get_residual_by_period
		return_value = 0
		if self && self.client && self.client.biddings.length > 0
			contract = Contract.find self.contract.id
			self.client.biddings.each do |bidding|
				if bidding.residual_value_contract
					value = Contract.return_string_like_number(bidding.residual_value_contract).to_f
					if value
						return_value = return_value + value
					end
				end
			end
		end
		return Contract.return_number_like_string(return_value,1)
	end

	def get_total_by_period
		return_value = 0

		brs_comission_final = Contract.return_string_like_number(get_comission_brs_by_period).to_f 
		residual_final = Contract.return_string_like_number(get_residual_by_period).to_f 
		third_final = Contract.return_string_like_number(get_third_by_period).to_f 
		mulct_final = Contract.return_string_like_number(self.contractual_mulct).to_f 
		
		if brs_comission_final
			return_value = return_value + brs_comission_final
		end		
		if residual_final
			return_value = return_value + residual_final
		end	
		if third_final
			return_value = return_value + third_final
		end
		if mulct_final
			return_value = return_value + mulct_final
		end
		return Contract.return_number_like_string(return_value,1)
	end

	def get_commercial_agent_name
		if self && self.contract && self.contract.comercial_agent
			return self.contract.comercial_agent.name
		else
			return 'Não selecionado'
		end
	end

	def get_commercial_agent_comission
		return_value = 0
		if self && self.client && self.client.biddings.length > 0
			contract = Contract.find self.contract.id
			self.client.biddings.each do |bidding|
				bidding_proposals = bidding.bidding_proposals.select{|item| item[:participation_result_id] == 1 && (item[:competition_status_id] == 2 || item[:competition_status_id] == 3 || item[:competition_status_id] == 4 )}
				bidding_proposals.each do |proposal|
					value = Contract.return_string_like_number(proposal.consultant_comission).to_f
					if value
						return_value = return_value + value
					end
				end
			end
		end
		return Contract.return_number_like_string(return_value,1)
	end

	def get_intermediary_comission
		return_value = 0
		if self && self.client && self.client.biddings.length > 0
			contract = Contract.find self.contract.id
			self.client.biddings.each do |bidding|
				bidding_proposals = bidding.bidding_proposals.select{|item| item[:participation_result_id] == 1 && (item[:competition_status_id] == 2 || item[:competition_status_id] == 3 || item[:competition_status_id] == 4 )}
				bidding_proposals.each do |proposal|
					value = Contract.return_string_like_number(proposal.intermediary_comission).to_f
					if value
						return_value = return_value + value
					end
				end
			end
		end
		return Contract.return_number_like_string(return_value,1)
	end

	def get_intermediary_name
		if self && self.contract && self.contract.intermediary
			return self.contract.intermediary.name
		else
			return 'Não selecionado'
		end
	end

	def get_third_by_period
		return_value = 0
		if self && self.financial_thirds.length > 0
			self.financial_thirds.each do |third|
				if third.value
					value_service = Contract.return_string_like_number(third.value).to_f
				end
				if value_service
					if third.quantity
						quantity = Contract.return_string_like_number(third.quantity).to_f
						value_service = value_service * quantity
					end
					return_value = (return_value + value_service).round(2)
				end
			end
		end
		return Contract.return_number_like_string(return_value,1)
	end

end
