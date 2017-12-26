class Audit < ActiveRecord::Base

	def get_name_type
		case self.auditable_type 
		when "User"    
			return "Usuário" 
		when "Product"    
			return "Produto"
		when "Organ"    
			return "Orgão"
		when "Sector"    
			return "Setor"
		when "Client"    
			return "Cliente"
		when "ClientSegment"    
			return "Segmento de cliente"
		when "ClientClient"    
			return "Cliente do cliente"
		when "WordsKey"    
			return "Palavra chave"
		when "ClientContability"    
			return "Dados de contabilidade"
		when "PhoneUser"    
			return "Telefone"
		when "EmailUser"    
			return "Email"
		when "ContabilityContact"    
			return "Contato da contabilidade"
		when "ContabilitySecondaryContact"    
			return "Contador secundário"
		when "ClientBank"    
			return "Banco"
		when "PhoneSector"    
			return "Telefone setor"
		when "EmailSector"    
			return "Email setor"
		when "ClientDocument"    
			return "Documento"
		when "ClientContact"    
			return "Contato cliente"
		when "VisitsReport"    
			return "Visita"
		when "Proposal"    
			return "Proposta"
		when "CalendarEvent"    
			return "Evento"
		when "Contract"    
			return "Contrato"
		when "ContractPayment"    
			return "Pagamento do contrato"
		when "ContractResponsible"    
			return "Responsável do contrato"
		when "ContractResponsibleFinancial"    
			return "Responsável fiscal do contrato"
		when "EntityClass"    
			return "Entidade de classe"
		when "EntityClassResponsible"    
			return "Responsável entidade de classe"
		when "MonthlyValue"    
			return "Valor mensal"
		when "ProposalHistoric"    
			return "Histórico de proposta"
		when "UploadProposal"    
			return "Upload de proposta"
		when "Portal"    
			return "Portal"
		when "OfficialDiary"    
			return "Diário Oficial"
		when "BidNewspaper"    
			return "Jornal de Licitação"
		when "Bidding"    
			return "Licitação"
		when "Attachment"    
			return "Anexo"
		when "Observation"    
			return "Observação"
		when "Lawyer"    
			return "Advogado"
		when "Piece"    
			return "Peça"
		when "LibraryCategory"    
			return "Categoria"
		else
			return "-"
		end
	end

end