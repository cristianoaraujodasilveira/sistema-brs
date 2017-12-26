class ClientsController < ApplicationController

	before_action :register

	def index
		@grid_clients = ClientsGrid.new(params[:clients_grid]) do |scope|
			scope.page(params[:page])
		end
		client_id = params[:format]
		if client_id && client_id != 0 && client_id != '0'
			@client = Client.includes(:client_documents).where(:id => client_id).first
			@show_grid_client_document = true

			@documents_1 = @client.client_documents.select{|item| item[:client_document_type_id] == 1}
			@documents_2 = @client.client_documents.select{|item| item[:client_document_type_id] == 2}
			@documents_3 = @client.client_documents.select{|item| item[:client_document_type_id] == 3}
			@documents_4 = @client.client_documents.select{|item| item[:client_document_type_id] == 4}
			@documents_5 = @client.client_documents.select{|item| item[:client_document_type_id] == 5}
			@documents_6 = @client.client_documents.select{|item| item[:client_document_type_id] == 6}
			@documents_7 = @client.client_documents.select{|item| item[:client_document_type_id] == 7}

		end
		if params[:client_documents_grid]
			@show_grid_client_document = true
		end
	end

	def new
		@client = Client.new
		build_initials_relations
		@active = 1
	end

	def edit
		@client = Client.find params[:id]
		build_initials_relations
		active_step_form(params)
	end

	def redirect_to_edit_step(params)
		if params[:save_1]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '1'
		elsif params[:save_2]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '2'
		elsif params[:save_3]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '3'
		elsif params[:save_4]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '4'
		elsif params[:save_5]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '5'
		elsif params[:save_6]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6'
		elsif params[:save_6_1]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_1'
		elsif params[:save_6_2]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_2'
		elsif params[:save_6_3]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_3'
		elsif params[:save_6_4]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_4'
		elsif params[:save_6_5]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_5'
		elsif params[:save_6_6]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_6'
		elsif params[:save_6_7]
			redirect_to controller: 'clients', action: 'edit', id: @client.id, step: '6_7'
		end
	end

	def build_initials_relations
		# Clientes filhos
		if @client.client_segment == nil
			# Segmento
			@client.build_client_segment
		end
		if @client.client_contability == nil
			# Contabilidade
			@client.build_client_contability
		end
		build_to_show
	end

	def build_to_show
		# Palavras chaves
		if @client.client_segment.words_keys.length == 0
			@client.client_segment.words_keys.build
		end
		# Telefones da contabilidade
		if @client.client_contability.phone_users.length == 0
			@client.client_contability.phone_users.build
		end
		# Emails da contabilidade
		if @client.client_contability.email_users.length == 0
			@client.client_contability.email_users.build
		end
		# Contato da contabilidade
		if @client.client_contability.contability_contacts.length == 0
			@client.client_contability.contability_contacts.build
		end
		# Contato secundário da contabilidade
		if @client.client_contability.contability_secondary_contacts.length == 0
			@client.client_contability.contability_secondary_contacts.build
		end
		# Contas bancárias
		if @client.client_banks.length == 0
			@client.client_banks.build
		end
		# Documentos 1 
		@client.client_documents.build(:client_document_type_id => 1, :subfolder_document_id => 1)
		# Documentos 2 
		@client.client_documents.build(:client_document_type_id => 2, :subfolder_document_id => 5)
		# Documentos 3 
		@client.client_documents.build(:client_document_type_id => 3, :subfolder_document_id => 9)
		# Documentos 4
		@client.client_documents.build(:client_document_type_id => 4, :subfolder_document_id => 14)
		# Documentos 5
		@client.client_documents.build(:client_document_type_id => 5)
		# Documentos 6
		@client.client_documents.build(:client_document_type_id => 6, :subfolder_document_id => 23)
		# Documentos 7
		@client.client_documents.build(:client_document_type_id => 7)
		# Contatos comerciais
		if @client.client_contacts.select{|item| item[:client_contact_type_id] == 1}.length == 0
			@client.client_contacts.build(:client_contact_type_id => 1)
		end 
		# Contatos fiscais
		if @client.client_contacts.select{|item| item[:client_contact_type_id] == 2}.length == 0
			@client.client_contacts.build(:client_contact_type_id => 2)
		end 
		build_client_contacts_attributes
	end

	def build_client_contacts_attributes
		@client.client_contacts.each do |client|
			if client.phone_users.length == 0
				client.phone_users.build
			end
			if client.email_users.length == 0
				client.email_users.build
			end
		end
	end

	def create
		@client = Client.new(client_params)
		build_to_show
		if params[:add_branch]
		    # Adicionando filial na tela de dados da empresa
		    @client.clients.build
		    @active = 1
		    render :new
		elsif params[:add_client]
		    # Adicionando clientes na tela de dados da empresa
		    @client.client_clients.build
		    @active = 1
		    render :new
		elsif params[:add_word_key]
			# Adicionado palavras chaves na tela de segmentos
			@client.client_segment.words_keys.build
			@active = 2
			render :new
		elsif params[:add_contact_name]
			# Adicionado nome do contador na tela de contabilidade
			@client.client_contability.contability_contacts.build
			@active = 3
			render :new
		elsif params[:add_contact_secondary]
			# Adicionado contador secundário na tela de contabilidade
			@client.client_contability.contability_secondary_contacts.build
			@active = 3
			render :new	
		elsif params[:add_email]
			# Adicionado email na tela de contabilidade
			@client.client_contability.email_users.build
			@active = 3
			render :new	
		elsif params[:add_phone]
			# Adicionado telefone na tela de contabilidade
			@client.client_contability.phone_users.build
			@active = 3
			render :new	
		elsif params[:add_contact_comercial]
			# Adicionado contato comercial na tela de contato
			@client.client_contacts.build(:client_contact_type_id => 1)
			build_client_contacts_attributes
			@active = 4
			render :new		
		elsif params[:add_contact_fiscal]
			# Adicionado contato fiscal na tela de contato
			@client.client_contacts.build(:client_contact_type_id => 2)
			build_client_contacts_attributes
			@active = 4
			render :new	
		elsif params[:add_account_bank]
			# Adicionado conta bancária na tela de dados bancários
			@client.client_banks.build
			@active = 5
			render :new	
		elsif params[:remove_data_1]
			# Removendo dados na tela de dados da empresa
			@active = 1
			render :new
		elsif params[:remove_data_2]
			# Removendo dados na tela de segmentos
			@active = 2
			render :new
		elsif params[:remove_data_3]
			# Removendo dados na tela de contabilidade
			@active = 3
			render :new
		elsif params[:remove_data_4]
			# Removendo dados na tela de contato
			@active = 4
			render :new
		elsif params[:remove_data_5]
			# Removendo dados na tela de dados bancários
			@active = 5
			render :new
		elsif params[:remove_data_6_1]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 1
			render :new
		elsif params[:remove_data_6_2]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 2
			render :new
		elsif params[:remove_data_6_3]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 3
			render :new
		elsif params[:remove_data_6_4]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 4
			render :new
		elsif params[:remove_data_6_5]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 5
			render :new
		elsif params[:remove_data_6_6]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 6
			render :new
		elsif params[:remove_data_6_7]
			# Removendo dados na tela de documentos
			@active = 6
			@document_type = 7
			render :new
		else
	        # save goes like usual
	        if params[:save_1]
	        	@client.step = 1
	        elsif params[:save_4]
	        	@client.step = 4
	        elsif params[:save_5]
	        	@client.step = 5
	        end
	        if @client.save
	        	audit = @client.audits.last
	        	audit.comment = "Criou o cliente '"+@client.social_name+"' de id #"+@client.id.to_s
	        	audit.save
	        	gflash :success => "Cliente cadastrado com sucesso"
	        	delete_invalid_data
	        	ClientDocument.update_documents_by_client(@client.id)
	        	redirect_to_edit_step(params)
	        else
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@client.errors.full_messages.join('<br>')
	        	active_step_form(params)
	        	render :new
	        end
	    end
	end

	def delete_invalid_data
		documents = ClientDocument.where(:document_file_name => nil).where(:client_id => @client.id)
		documents.destroy_all
	end

	def build_in_edit(client_params)
		unless client_params[:clients_attributes].blank?
			for attribute in client_params[:clients_attributes]
				@client.clients.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_clients_attributes].blank?
			for attribute in client_params[:client_clients_attributes]
				@client.client_clients.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_segment_attributes][:words_keys_attributes].blank?
			for attribute in client_params[:client_segment_attributes][:words_keys_attributes]
				@client.client_segment.words_keys.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_contability_attributes][:contability_contacts_attributes].blank?
			for attribute in client_params[:client_contability_attributes][:contability_contacts_attributes]
				@client.client_contability.contability_contacts.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_contability_attributes][:contability_secondary_contacts_attributes].blank?
			for attribute in client_params[:client_contability_attributes][:contability_secondary_contacts_attributes]
				@client.client_contability.contability_secondary_contacts.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_contability_attributes][:email_users_attributes].blank?
			for attribute in client_params[:client_contability_attributes][:email_users_attributes]
				@client.client_contability.email_users.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_contability_attributes][:phone_users_attributes].blank?
			for attribute in client_params[:client_contability_attributes][:phone_users_attributes]
				@client.client_contability.phone_users.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_banks_attributes].blank?
			for attribute in client_params[:client_banks_attributes]
				@client.client_banks.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless client_params[:client_contacts_attributes].blank?
			for attribute in client_params[:client_contacts_attributes]
				@client.client_contacts.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		build_client_contacts_attributes
	end

	def update
		@client = Client.find(params[:id])
		if params[:add_branch]
			# Adicionando filial na tela de dados da empresa
			build_in_edit(client_params)
			@client.clients.build
			@active = 1
			render :edit
		elsif params[:add_client]
		    # Adicionando clientes na tela de dados da empresa
		    build_in_edit(client_params)
		    @client.client_clients.build
		    @active = 1
		    render :edit
		elsif params[:add_word_key]
			# Adicionando palavras chaves na tela de segmentos
			build_in_edit(client_params)
			@client.client_segment.words_keys.build
			@active = 2
			render :edit
		elsif params[:add_contact_name]
			# Adicionando nome do contador na tela de contabilidade
			build_in_edit(client_params)
			@client.client_contability.contability_contacts.build
			@active = 3
			render :edit
		elsif params[:add_contact_secondary]
			# Adicionando contador secundário na tela de contabilidade
			build_in_edit(client_params)
			@client.client_contability.contability_secondary_contacts.build
			@active = 3
			render :edit
		elsif params[:add_email]
			# Adicionando email na tela de contabilidade
			build_in_edit(client_params)
			@client.client_contability.email_users.build
			@active = 3
			render :edit
		elsif params[:add_phone]
			# Adicionando telefone na tela de contabilidade
			build_in_edit(client_params)
			@client.client_contability.phone_users.build
			@active = 3
			render :edit
		elsif params[:add_contact_comercial]
			# Adicionando contato comercial na tela de contato
			build_in_edit(client_params)
			@client.client_contacts.build(:client_contact_type_id => 1)
			build_client_contacts_attributes
			@active = 4
			render :edit
		elsif params[:add_contact_fiscal]
			# Adicionando contato fiscal na tela de contato
			build_in_edit(client_params)
			@client.client_contacts.build(:client_contact_type_id => 2)
			build_client_contacts_attributes
			@active = 4
			render :edit
		elsif params[:add_account_bank]
			# Adicionando conta bancária na tela de dados bancários
			build_in_edit(client_params)
			@client.client_banks.build
			@active = 5
			render :edit
		elsif params[:remove_data_1]
			# Removendo dados na tela de dados da empresa
			@active = 1
			render :edit
		elsif params[:remove_data_2]
			# Removendo dados na tela de segmentos
			@active = 2
			render :edit
		elsif params[:remove_data_3]
			# Removendo dados na tela de contabilidade
			@active = 3
			render :edit
		elsif params[:remove_data_5]
			# Removendo dados na tela de contabilidade
			@active = 5
			render :edit
		else
			if params[:save_1]
				@client.step = 1
			elsif params[:save_4]
				@client.step = 4
			elsif params[:save_5]
				@client.step = 5
			end
			if @client.update_attributes client_params
				save_audit
				ClientDocument.update_documents_by_client(@client.id)
				gflash :success => "Cliente editado com sucesso"
				redirect_to_edit_step(params)
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@client.errors.full_messages.join('<br>')
				active_step_form(params)
				render :edit
			end
		end
	end

	def save_audit
		audit = @client.audits.last
		if audit && audit.comment == nil 
			audit.comment = "Editou o cliente '"+@client.social_name+"' de id #"+@client.id.to_s
			audit.save
		else
			audit = Audit.last
			if audit && audit.comment == nil 
				if audit.action == 'create'
					text = "Criou"
				elsif audit.action == 'update'
					text = "Editou"
				elsif audit.action == 'destroy'
					text = "Apagou"
				end
				type = "desconhecido"
				if audit.auditable_type == 'ClientClient'
					type = "o cliente"
				elsif audit.auditable_type == 'ClientSegment'
					type = "o segmento"
				elsif audit.auditable_type == 'WordsKey'
					type = "a palavra chave"
				elsif audit.auditable_type == 'ContabilitySecondaryContact'
					type = "o contato secundário da contabilidade"
				elsif audit.auditable_type == 'ContabilityContact'
					type = "o contato da contabilidade"
				elsif audit.auditable_type == 'EmailUser'
					type = "o email da contabilidade"
				elsif audit.auditable_type == 'PhoneUser'
					type = "o telefone da contabilidade"
				elsif audit.auditable_type == 'ContabilityContact'
					type = "o contato da contabilidade"
				elsif audit.auditable_type == 'ContabilitySecondaryContact'
					type = "o contador secundário da contabilidade"
				elsif audit.auditable_type == 'ContabilityContact'
					type = "o telefone da contabilidade"
				elsif audit.auditable_type == 'ClientBank'
					type = "o banco"
				elsif audit.auditable_type == 'ClientDocument'
					type = "o documento"
				end
				audit.comment = text+" "+type+" do cliente '"+@client.social_name+"' de id #"+@client.id.to_s
				audit.save
			end
		end
	end

	def active_step_form(params)
		if params[:save_1] || params[:step] == '1'
			@active = 1
		elsif params[:save_2] || params[:step] == '2'
			@active = 2
		elsif params[:save_3] || params[:step] == '3'
			@active = 3
		elsif params[:save_4] || params[:step] == '4'
			@active = 4
		elsif params[:save_5] || params[:step] == '5'
			@active = 5
		elsif params[:save_6] || params[:step] == '6'
			@active = 6
		elsif params[:save_6_1] || params[:step] == '6_1'
			@active = 6
			@document_type = 1
		elsif params[:save_6_2] || params[:step] == '6_2'
			@active = 6
			@document_type = 2
		elsif params[:save_6_3] || params[:step] == '6_3'
			@active = 6
			@document_type = 3
		elsif params[:save_6_4] || params[:step] == '6_4'
			@active = 6
			@document_type = 4
		elsif params[:save_6_5] || params[:step] == '6_5'
			@active = 6
			@document_type = 5
		elsif params[:save_6_6] || params[:step] == '6_6'
			@active = 6
			@document_type = 6
		elsif params[:save_6_7] || params[:step] == '6_7'
			@active = 6
			@document_type = 7
		else
			@active = 1
		end
	end

	def destroy
		client = Client.find params[:id]
		if client 
			client.destroy
			audit = client.audits.last
			audit.comment = "Apagou o cliente '"+client.social_name+"' de id #"+client.id.to_s
			audit.save
			gflash :success => "Cliente excluído com sucesso"
		end
		redirect_to clients_path
	end

	def get_informations
		data = Client.where('id = ?', params[:id]).first
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def get_subfolders_client_document_type
		data = SubfolderDocument.where('client_document_type_id = ?', params[:client_document_type_id]).order("LENGTH(name) ASC")
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	private
	def client_params
		params.require(:client).permit(
			:id,
			:logo,
			:stamp,
			:social_name,
			:fantasy_name,
			:cnpj,
			:site,
			:municipal_registration,
			:state_registration,
			:client_id, 
			:client_company_size_id,
			:client_periodicity_id,
			:client_type_id,
			:client_status_id,
			:client_class_id,
			:bid_participant,
			:delete_logo,
			:delete_stamp,
			:proposal_id,
			:step,
			:user_ids => [],
			clients_attributes: [
				:id,
				:_destroy,
				:logo,
				:stamp,
				:social_name,
				:fantasy_name,
				:cnpj,
				:site,
				:delete_logo,
				:delete_stamp,
				:municipal_registration,
				:state_registration,
				:client_id, 
				:client_company_size_id,
				:client_periodicity_id,
				:client_type_id,
				:client_status_id,
				:client_class_id,
				:bid_participant
				],
				client_clients_attributes: [
					:id,
					:_destroy,
					:client_id,
					:client_children_id
					],
					client_segment_attributes: [
						:id,
						:client_id,
						:name,
						:products_services,
						words_keys_attributes: [
							:_destroy,
							:id,
							:word
						]
						],
						client_contability_attributes: [
							:id,
							:name,
							:client_id,
							:zipcode,
							:address,
							:district,
							:number,
							:complement,
							:state_id, 
							:city_id,
							:extern_contability,
							:intern_contability,
							phone_users_attributes: [
								:id,
								:_destroy,
								:phone
								],
								email_users_attributes: [
									:id,
									:_destroy,
									:email
									],
									contability_contacts_attributes: [
										:id,
										:_destroy,
										:name
										],
										contability_secondary_contacts_attributes: [
											:id,
											:_destroy,
											:name
										]	
										],
										client_banks_attributes: [
											:id,
											:_destroy,
											:client_id,
											:account_number,
											:owner_account,
											:bank_name,
											:bank_code,
											:agency_number,
											:agency_name,
											:cnpj,
											:operation, 
											:account_bank_type_id
											],
											client_documents_attributes: [
												:id,
												:_destroy,
												:client_id,
												:document,
												:due_date,
												:emission_date,
												:client_document_type_id,
												:client_document_status_id,
												:subfolder_document_id,
												:client_document_notification_id
												],
												client_contacts_attributes: [
													:id,
													:_destroy,
													:client_id,
													:zipcode,
													:address,
													:district,
													:number,
													:complement,
													:state_id, 
													:city_id,
													:responsible_name,
													:office,
													:department,
													:whatsapp,
													:skype,
													:client_class_id,
													:client_contact_type_id,
													phone_users_attributes: [
														:id,
														:_destroy,
														:phone
														],
														email_users_attributes: [
															:id,
															:_destroy,
															:email
														]
													]	
													)
	end
end
