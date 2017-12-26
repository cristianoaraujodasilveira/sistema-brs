class ContractsController < ApplicationController

	before_action :commercial
	
	def index
		@grid_contracts = ContractsGrid.new(params[:contracts_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@contract = Contract.new
		@active = 1
		build_contracts
	end

	def edit
		@contract = Contract.find params[:id]
		@active = 1
		build_contracts
	end

	def build_contracts
		if @contract.contract_responsibles.length == 0
			@contract.contract_responsibles.build
		end
		if @contract.contract_payments.length == 0
			@contract.contract_payments.build
		end
		if @contract.contract_responsible_financials.length == 0
			@contract.contract_responsible_financials.build
		end
		if @contract.attachments.select{ |item| item[:id] == nil }.length == 0
			@contract.attachments.build
		end
		build_contracts_attributes
	end

	def build_contracts_attributes
		@contract.contract_responsibles.each do |contract_responsible|
			contract_responsible.phone_users.build
			contract_responsible.email_users.build
		end
		@contract.contract_responsible_financials.each do |contract_responsible|
			contract_responsible.phone_users.build
			contract_responsible.email_users.build
		end
	end

	def create
		@contract = Contract.new(contract_params)
		if params[:add_responsible]
		    # add empty contract associated with @contract
		    @contract.contract_responsibles.build
		    build_contracts
		    @active = 1
		    render :new
		elsif params[:add_payment]
			@contract.contract_payments.build
			build_contracts
			@active = 2
			render :new
		elsif params[:add_responsible_financial]
			@contract.contract_responsible_financials.build
			build_contracts
			@active = 2
			render :new
		elsif params[:remove_data_1]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_contracts
		    @active = 1
		    render :new
		elsif params[:remove_data_2]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_contracts
		    @active = 2
		    render :new
		else
			# save goes like usual
			if params[:save_1]
				@contract.step = 1
				@active = 1
			elsif params[:save_2]
				@contract.step = 2
				@active = 2
			elsif params[:save_3]
				@contract.step = 3
				@active = 3
			elsif params[:save_4]
				@contract.step = 4
				@active = 4
			end
	        # save goes like usual
	        if @contract.save
	        	audit = @contract.audits.last
	        	audit.comment = "Criou o contrato '"+@contract.title+"' de id #"+@contract.id.to_s
	        	audit.save
	        	gflash :success => "Contrato cadastrado com sucesso"
	        	generate_notification('create')
	        	Contract.update_monthly_payment(@contract)
	        	Contract.update_comission(@contract)
	        	redirect_to edit_contract_path @contract
	        else
	        	build_contracts
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@contract.errors.full_messages.join('<br>')
	        	render :new
	        end
	    end
	end

	def build_in_edit(contract_params)
		unless contract_params[:contract_responsibles_attributes].blank?
			for attribute in contract_params[:contract_responsibles_attributes]
				@contract.contract_responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless contract_params[:contract_payments_attributes].blank?
			for attribute in contract_params[:contract_payments_attributes]
				@contract.contract_payments.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless contract_params[:contract_responsible_financials_attributes].blank?
			for attribute in contract_params[:contract_responsible_financials_attributes]
				@contract.contract_responsible_financials.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def update
		@contract = Contract.find(params[:id])

		if params[:add_responsible]
			build_in_edit(contract_params)
	      	# add one more empty contract attribute
	      	@contract.contract_responsibles.build
	      	build_contracts
	      	@active = 1
	      	render :edit
	      elsif params[:add_payment]
	      	build_in_edit(contract_params)
	      	# add one more empty sector attribute
	      	@contract.contract_payments.build
	      	build_contracts
	      	@active = 2
	      	render :edit
	      elsif params[:add_responsible_financial]
	      	build_in_edit(contract_params)
	      	# add one more empty sector attribute
	      	@contract.contract_responsible_financials.build
	      	build_contracts
	      	@active = 2
	      	render :edit
	      elsif params[:remove_data_1]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_contracts
		    @active = 1
		    render :edit
		elsif params[:remove_data_2]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_contracts
		    @active = 2
		    render :edit
		elsif params[:export_draft_pdf]
			@contract.update_attributes contract_params
		    # create a pdf from a string
		    pdf = WickedPdf.new.pdf_from_string(@contract.draft_contact)
		    if @contract.proposal != nil
		    	send_data(pdf, filename: @contract.proposal.social_name+"_contrato.pdf")	
		    else
		    	send_data(pdf, filename: "contrato.pdf")	
		    end
		elsif params[:save_and_redirect_to_send_email]
			@contract.update_attributes contract_params
		    # create a pdf from a string
		    redirect_to draft_contract_email_path(@contract)
		elsif params[:send_email_contract]
		    # create a pdf from a string
		    result = send_email_contract(params)
		    if result
		    	gflash :success => "Email enviado com sucesso"
		    else
		    	gflash :now, :error => "Preencha os campos corretamente!"
		    end
		    redirect_to draft_contract_email_path @contract
		else
	        # save goes like usual
	        if params[:save_1]
	        	@contract.step = 1
	        	@active = 1
	        elsif params[:save_2]
	        	@contract.step = 2
	        	@active = 2
	        elsif params[:save_3]
	        	@contract.step = 3
	        	@active = 3
	        elsif params[:save_4]
	        	@contract.step = 4
	        	@active = 4
	        end
	        if @contract.update_attributes contract_params
	        	audit = @contract.audits.last
	        	if audit
	        		audit.comment = "Editou o contrato '"+@contract.title+"' de id #"+@contract.id.to_s
	        		audit.save
	        	else
	        		audit = Audit.last
	        		if audit && audit.comment == nil && audit.auditable_type == 'Sector'
	        			if audit.action == 'create'
	        				text = "Criou"
	        			elsif audit.action == 'update'
	        				text = "Editou"
	        			elsif audit.action == 'destroy'
	        				text = "Apagou"
	        			end
	        			audit.comment = text+" o setor de id #"+audit.auditable_id.to_s+" do orgão de id #"+@contract.id.to_s
	        			audit.save
	        		end
	        	end
	        	generate_notification('update')
	        	Contract.update_monthly_payment(@contract)
	        	Contract.update_comission(@contract)
	        	gflash :success => "Contrato editado com sucesso"
	        	if params[:save_draft_contract]
	        		redirect_to draft_contract_edit_path @contract
	        	else
	        		redirect_to edit_contract_path @contract
	        	end
	        else
	        	build_contracts
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@contract.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		@contract = Contract.find params[:id]
		if @contract 
			@contract.destroy
			audit = @contract.audits.last
			audit.comment = "Apagou o contrato '"+@contract.title+"' de id #"+@contract.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Contrato excluído com sucesso"
		end
		redirect_to contracts_path
	end

	def delete_sector
		sector = Sector.find params[:format]
		if sector 
			sector.destroy
			audit = sector.audits.last
			audit.comment = "Apagou o setor '"+sector.name+"' de id #"+sector.id.to_s+" do orgão de id #"+sector.contract_id.to_s
			audit.save
			gflash :success => "Setor excluído com sucesso"
		end
		redirect_to :back
	end

	def get_contracts_values_to_graphic
		spheres = Sphere.all
		values = Array.new;
		spheres.each do |sp|
			contracts = contract.where(:sphere_id => sp.id).count
			data = {
				:name => sp.name,
				:y => contracts
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end


	def draft_contract_edit
		@contract = Contract.find params[:id]
		if @contract.draft_contact == nil
			@contract.draft_contact = ContractModel.first.draft_contact.gsub("\u0000", '')
		end
		format_draft_contract
	end

	def draft_contract_email
		@contract = Contract.find params[:id]
		pdf = WickedPdf.new.pdf_from_string(@contract.draft_contact)
		if @contract.proposal != nil
			@filename = @contract.proposal.social_name+"_contrato.pdf"
		else
			@filename = "contrato.pdf"
		end
	end

	def draft_contract_download
		@contract = Contract.find params[:id]
		pdf = WickedPdf.new.pdf_from_string(@contract.draft_contact)
		if @contract.proposal != nil
			send_data(pdf, filename: @contract.proposal.social_name+"_contrato.pdf")	
		else
			send_data(pdf, filename: "contrato.pdf")	
		end
	end

	def send_email_contract(params)
		if contract_params[:subject] == nil || contract_params[:email] == nil || contract_params[:subject] == "" || contract_params[:email] == ""
			return false
		else
			pdf = WickedPdf.new.pdf_from_string(@contract.draft_contact)
			if @contract.proposal != nil
				filename = @contract.proposal.social_name+"_contrato.pdf"
			else
				filename = "contrato.pdf"
			end
			if @current_user.email
				from = @current_user.email
			else
				from = "contato@brs.com.br"
			end
			ApplicationMailer.send_email_with_contract_message(from, contract_params[:subject], contract_params[:email], contract_params[:cc], contract_params[:cco], contract_params[:message], filename, pdf).deliver_now
		end
	end

	def format_draft_contract
		@contract.draft_contact = @contract.draft_contact.gsub("\u0000", '')
		if @contract.client
			@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_RAZAO_SOCIAL]", @contract.client.social_name)
			@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_NOME_EMPRESA]", @contract.client.social_name)
			@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_CNPJ]", @contract.client.cnpj)
			if @contract.client.client_contacts.length > 0
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_LOGRADOURO]", @contract.client.client_contacts[0].address)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_NUMERO]", @contract.client.client_contacts[0].number)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_COMPLEMENTO]", @contract.client.client_contacts[0].complement)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_BAIRRO]", @contract.client.client_contacts[0].district)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_CIDADE]", @contract.client.client_contacts[0].city.name)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_ESTADO]", @contract.client.client_contacts[0].state.name)
				@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_ENDERECO_CEP]", @contract.client.client_contacts[0].zipcode)
			end
		end
		if @contract.contract_payments.length > 0 && @contract.contract_payments[0].payment_scopes != nil && @contract.contract_payments[0].payment_scopes.length > 0
			@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_AMBITO]", @contract.contract_payments[0].payment_scopes.pluck(:name).join(', '))
		end
		@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_DATA_DIA_NUMERO]", I18n.l(DateTime.now, format: :just_day))
		@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_DATA_MES_EXTENSO]", I18n.l(DateTime.now, format: :just_month))
		@contract.draft_contact = @contract.draft_contact.gsub("[CLIENTE_DATA_ANO_NUMERO]", I18n.l(DateTime.now, format: :just_year))
	end

	def get_contracts_values_to_graphic
		users = User.where(:profile_id => [1,3])
		values = Array.new;
		users.each do |user|
			contracts = Contract.where(:user_id => user.id).count
			data = {
				:name => user.name,
				:y => contracts,
				:color => user.calendar_color.code
			}
			values.push(data)
		end
		respond_to do |format|
			format.json {render :json => values, :status => 200}
		end
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'create'
				text = Contract.notification_new_contract(@contract, @current_user)
				action_notification_id = 10
			elsif type == 'update'
				text = Contract.notification_edit_contract(@contract, @current_user)
				action_notification_id = 11
			elsif type == 'destroy'
				text = Contract.notification_delete_contract(@contract, @current_user)
				action_notification_id = 12
			end
			User.unblocked.each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 2
				notification.sender = @current_user
				notification.receiver = user
				notification.text = text
				notification.save
			end
		end
	end

	def update_values_contracts
		contracts = Contract.all
		contracts.each do |contract|
			Contract.Contract.update_monthly_payment(contract)
			Contract.Contract.update_comission(contract)
		end
		redirect_to contracts_path
	end

	def delete_attachment_contract
		result = false
		attachment = Attachment.find params[:attachment_id]
		if attachment 
			if attachment.destroy
				result = true
			end
		end
		data = {
			:result => result
		}
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	private
	def contract_params
		params.require(:contract).permit(
			:id,
			:client_id,
			:proposal_id,
			:user_id,
			:title,
			:monthly_fixed_payment,
			:monthly_payment,
			:monthly_discount,
			:monthly_initial_date,
			:monthly_final_date,
			:comission_fixed_payment,
			:comission_payment,
			:comission_discount,
			:comission_initial_date,
			:comission_final_date,
			:fixed_value, 
			:comission_value,
			:discount_value,
			:pre_established_initial_date,
			:pre_established_final_date,
			:undetermined,
			:draft_contact,
			:subject, 
			:email, 
			:cc, 
			:cco, 
			:message,
			:comercial_agent_id,
			:intermediary_id,
			:fixed_value_intermediary,
			:discount_value_intermediary,
			:comission_value_intermediary,
			:user_ids => [],
			attachments_attributes: [
				:id,
				:attachment,
				:attachment_type
				],
				contract_responsibles_attributes: [
					:id,
					:contract_id,
					:_destroy,
					:name,
					:office,
					:department,
					:whatsapp,
					:skype,
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
						],
						contract_payments_attributes: [
							:id,
							:_destroy,
							:contract_id,
							:payment_form_id,
							:payment_from_id,
							:payment_sugestion_day_id,
							:all_scope,
							:payment_scope_ids => []
							],
							contract_responsible_financials_attributes: [
								:id,
								:contract_id,
								:_destroy,
								:name,
								:office,
								:department,
								:whatsapp,
								:skype,
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
