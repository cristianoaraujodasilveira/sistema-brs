class BiddingsController < ApplicationController

	before_action :bidding

	def index
		@grid_biddings = BiddingsGrid.new(params[:biddings_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@bidding = Bidding.new
		build_biddings
		@active = 1
	end

	def edit
		@bidding = Bidding.find params[:id]
		build_biddings
		active_step_form(params)
	end

	def build_biddings
		if @bidding.attachments.select{ |item| item[:attachment_type] == 1 && item[:id] == nil }.length == 0
			@bidding.attachments.build(:attachment_type => 1)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 2 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 2)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 3 && item[:id] == nil }.length == 0
			@bidding.attachments.build(:attachment_type => 3)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 4 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 4)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 5 && item[:id] == nil }.length == 0
			@bidding.attachments.build(:attachment_type => 5)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 6 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 6)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 7 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 7)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 8 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 8)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 9 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 9)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 10 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 10)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 11 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 11)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 12 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 12)
		end
		if @bidding.attachments.select{ |item| item[:attachment_type] == 13 && item[:id] == nil }.length == 0
			@bidding.attachments.build(attachment_type: 13)
		end
		if @bidding.bidding_responsibles.length == 0
			@bidding.bidding_responsibles.build
		end
		if @bidding.bidding_proposals.length == 0
			@bidding.bidding_proposals.build
		end
		if @bidding.bidding_resources.select{ |item| item[:resource_type] == 1 }.length == 0
			@bidding.bidding_resources.build(resource_type: 1)
		end
		if @bidding.bidding_resources.select{ |item| item[:resource_type] == 2 }.length == 0
			@bidding.bidding_resources.build(resource_type: 2)
		end
		@bidding.observations.build(observation_type: 1)
		@bidding.observations.build(observation_type: 2)
		@bidding.observations.build(observation_type: 3)
		@bidding.observations.build(observation_type: 4)
		build_biddings_attributes
	end

	def build_biddings_attributes
		@bidding.bidding_proposals.each do |responsible|
			if responsible.phones.length == 0
				responsible.phones.build
			end
			if responsible.emails.length == 0
				responsible.emails.build
			end
			if !responsible.address
				responsible.build_address
			end
		end
		@bidding.bidding_resources.each do |resource|
			resource.observations.build
			resource.attachments.build
		end
	end

	def build_in_create(params)
		if params[:add_document_1]
			@bidding.attachments.build(:attachment_type => 1)
		elsif params[:add_document_2]
			@bidding.attachments.build(:attachment_type => 2)
		elsif params[:add_document_3]
			@bidding.attachments.build(:attachment_type => 3)
		elsif params[:add_document_4]
			@bidding.attachments.build(:attachment_type => 4)
		elsif params[:add_document_5]
			@bidding.attachments.build(:attachment_type => 5)
		elsif params[:add_document_6]
			@bidding.attachments.build(:attachment_type => 6)
		elsif params[:add_document_7]
			@bidding.attachments.build(:attachment_type => 7)
		elsif params[:add_document_8]
			@bidding.attachments.build(:attachment_type => 8)
		elsif params[:add_document_9]
			@bidding.attachments.build(:attachment_type => 9)
		elsif params[:add_document_10]
			@bidding.attachments.build(:attachment_type => 10)
		elsif params[:add_document_11]
			@bidding.attachments.build(:attachment_type => 11)
		elsif params[:add_document_12]
			@bidding.attachments.build(:attachment_type => 12)
		elsif params[:add_document_13]
			@bidding.attachments.build(:attachment_type => 13)
		end
		build_biddings
		active_step_form(params)
		render :new
	end

	def create
		@bidding = Bidding.new(bidding_params)
		if params[:add_document_1] || params[:add_document_2] || params[:add_document_3] || params[:add_document_4] || params[:add_document_5] || params[:add_document_6] || params[:add_document_7] || params[:add_document_8] || params[:add_document_9] || params[:add_document_10] || params[:add_document_11] || params[:add_document_12] || params[:add_document_13]
			build_in_create(params)
		elsif params[:add_good_habit] || params[:add_accreditation_presential] || params[:add_habilitation] || params[:add_good_habit_participation] || params[:add_accreditation_presential_participation] || params[:add_habilitation] || params[:add_habilitation_participation]
			create_new_checklist(params)
			build_biddings
			active_step_form(params)
			render :new	
		elsif params[:add_responsible]
			@bidding.bidding_responsibles.build
			build_biddings_attributes
			active_step_form(params)
			render :new	
		elsif params[:add_bidding_proposal]
			@bidding.bidding_proposals.build
			build_biddings_attributes
			active_step_form(params)
			render :new	
		elsif params[:add_resource_1]
			@bidding.bidding_resources.build(:resource_type => 1)
			build_biddings_attributes
			active_step_form(params)
			render :new	
		elsif params[:add_resource_2]
			@bidding.bidding_resources.build(:resource_type => 2)
			build_biddings_attributes
			active_step_form(params)
			render :new	
		else
			if params[:save_capture]
				@bidding.step = 1
			elsif params[:save_read]
				@bidding.step = 2
			end
			if @bidding.save
				audit = @bidding.audits.last
				audit.comment = "Criou a licitação de id #"+@bidding.id.to_s
				audit.save
				gflash :success => "Licitação cadastrada com sucesso"

				if params[:save_capture]
					generate_notification('capture')
				elsif params[:save_read]
					generate_notification('read')
				elsif params[:save_participation]
					generate_notification('participation')
				end

				redirect_to_edit_step(params)
			else
				build_biddings
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@bidding.errors.full_messages.join('<br>')
				active_step_form(params)
				render :new
			end
		end
	end

	def build_in_edit(bidding_params)
		unless bidding_params[:attachments_attributes].blank?
			for attribute in bidding_params[:attachments_attributes]
				@bidding.attachments.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless bidding_params[:bidding_responsibles_attributes].blank?
			for attribute in bidding_params[:bidding_responsibles_attributes]
				@bidding.bidding_responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless bidding_params[:bidding_proposals_attributes].blank?
			for attribute in bidding_params[:bidding_proposals_attributes]
				@bidding.bidding_proposals.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless bidding_params[:bidding_resources_attributes].blank?
			for attribute in bidding_params[:bidding_resources_attributes]
				@bidding.bidding_resources.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
		unless bidding_params[:participation_user_ids].blank?
			@bidding.participation_user_ids = bidding_params[:participation_user_ids]
		end
	end

	def build_in_update(params)
		if params[:add_document_1]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 1)
		elsif params[:add_document_2]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 2)
		elsif params[:add_document_3]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 3)
		elsif params[:add_document_4]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 4)
		elsif params[:add_document_5]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 5)
		elsif params[:add_document_6]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 6)
		elsif params[:add_document_7]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 7)
		elsif params[:add_document_8]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 8)
		elsif params[:add_document_9]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 9)
		elsif params[:add_document_10]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 10)
		elsif params[:add_document_11]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 11)
		elsif params[:add_document_12]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 12)
		elsif params[:add_document_13]
			build_in_edit(bidding_params)
			@bidding.attachments.build(:attachment_type => 13)
		end
		active_step_form(params)
		build_biddings
		render :edit
	end

	def update
		@bidding = Bidding.find(params[:id])
		if params[:add_document_1] || params[:add_document_2] || params[:add_document_3] || params[:add_document_4] || params[:add_document_5] || params[:add_document_6] || params[:add_document_7] || params[:add_document_8] || params[:add_document_9] || params[:add_document_10] || params[:add_document_11] || params[:add_document_12] || params[:add_document_13]
			build_in_update(params)
		elsif params[:add_good_habit] || params[:add_accreditation_presential] || params[:add_good_habit_participation] || params[:add_accreditation_presential_participation] || params[:add_habilitation] || params[:add_habilitation_participation]
			create_new_checklist(params)
			build_biddings
			active_step_form(params)
			render :edit
		elsif params[:add_responsible]
			build_in_edit(bidding_params)
			@bidding.bidding_responsibles.build
			build_biddings
			active_step_form(params)
			render :edit	
		elsif params[:add_bidding_proposal]
			build_in_edit(bidding_params)
			@bidding.bidding_proposals.build
			build_biddings
			active_step_form(params)
			render :edit	
		elsif params[:add_resource_1]
			build_in_edit(bidding_params)
			@bidding.bidding_resources.build(:resource_type => 1)
			build_biddings
			active_step_form(params)
			render :edit	
		elsif params[:add_resource_2]
			build_in_edit(bidding_params)
			@bidding.bidding_resources.build(:resource_type => 2)
			build_biddings
			active_step_form(params)
			render :edit	
		else
			if params[:save_capture]
				@bidding.step = 1
			elsif params[:save_read]
				@bidding.step = 2
			elsif params[:save_participation]
				@bidding.step = 3
			end
			if @bidding.update_attributes bidding_params
				audit = @bidding.audits.last
				if audit
					audit.comment = "Editou o licitação de id #"+@bidding.id.to_s
					audit.save
				else
					audit = Audit.last
					if audit && audit.comment == nil && audit.auditable_type == 'bidding'
						if audit.action == 'create'
							text = "Criou"
						elsif audit.action == 'update'
							text = "Editou"
						elsif audit.action == 'destroy'
							text = "Apagou"
						end
						audit.comment = text+" a licitação de id #"+audit.auditable_id.to_s
						audit.save
					end
				end
				if params[:save_capture]
					generate_notification('capture')
				elsif params[:save_read]
					generate_notification('read')
				elsif params[:save_participation]
					generate_notification('participation')
				end

				gflash :success => "Licitação editada com sucesso"
				redirect_to_edit_step(params)
			else
				build_biddings
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@bidding.errors.full_messages.join('<br>')
				active_step_form(params)
				render :edit
			end
		end
	end

	def create_new_checklist(params)
		insert = false
		if (params[:add_good_habit] || params[:add_good_habit_participation])
			text = 'Checklist'
			letter = 'o'
			if params[:add_good_habit]
				if bidding_params[:good_habit_name_read] && bidding_params[:good_habit_name_read] != ''
					name = bidding_params[:good_habit_name_read]
				end
			else
				if bidding_params[:good_habit_name_participation] && bidding_params[:good_habit_name_participation] != ''
					name = bidding_params[:good_habit_name_participation]
				end
			end
			if name
				good_habit = GoodHabit.new(name: name)
				@bidding.good_habits << good_habit
				insert = true
			end
		elsif (params[:add_accreditation_presential] || params[:add_accreditation_presential_participation])
			text = 'Credenciamento presencial'
			letter = 'o'
			if params[:add_accreditation_presential]
				if bidding_params[:accreditation_presential_name_read] && bidding_params[:accreditation_presential_name_read] != ''
					name = bidding_params[:accreditation_presential_name_read]
				end
			else
				if bidding_params[:accreditation_presential_name_participation] && bidding_params[:accreditation_presential_name_participation] != ''
					name = bidding_params[:accreditation_presential_name_participation]
				end
			end
			if name
				accreditation_presential = AccreditationPresential.new(name: name)
				@bidding.accreditation_presentials << accreditation_presential
				insert = true
			end
		elsif (params[:add_habilitation] || params[:add_habilitation_participation])
			text = 'Habilitação'
			letter = 'a'
			if params[:add_habilitation]
				if bidding_params[:habilitation_name_read] && bidding_params[:habilitation_name_read] != ''
					name = bidding_params[:habilitation_name_read]
				end
			else
				if bidding_params[:habilitation_name_participation] && bidding_params[:habilitation_name_participation] != ''
					name = bidding_params[:habilitation_name_participation]
				end
			end
			if name
				habilitation = Habilitation.new(name: name)
				@bidding.habilitations << habilitation
				insert = true
			end
		end
		if insert
			gflash :success => text+" cadastrad"+letter+" com sucesso"
		else
			gflash :now, :error => text+" não cadastrad"+letter+" com sucesso. Preencha o campo 'nome' corretamente para salvar!"
		end
	end

	def active_step_form(params)
		if params[:save_capture] || params[:step] == '1' || params[:add_document_1] || params[:add_document_2] 
			@active = 1
		elsif params[:save_read] || params[:step] == '2' || params[:add_document_3] || params[:add_document_4] || params[:add_document_5] || params[:add_document_6] || params[:add_good_habit] || params[:add_accreditation_presential] || params[:add_habilitation]
			@active = 2
		elsif params[:save_participation] || params[:step] == '3' || params[:add_responsible] || params[:add_bidding_proposal] || params[:add_document_7] || params[:add_document_8] || params[:add_document_9] || params[:add_document_10] || params[:add_document_11] || params[:add_document_12] || params[:add_document_13] || params[:add_resource_1] || params[:add_resource_2] || params[:add_good_habit_participation] || params[:add_accreditation_presential_participation] || params[:add_habilitation_participation]
			@active = 3
		else
			@active = 1
		end
	end

	def redirect_to_edit_step(params)
		if params[:save_capture]
			redirect_to controller: 'biddings', action: 'edit', id: @bidding.id, step: '1'
		elsif params[:save_read]
			redirect_to controller: 'biddings', action: 'edit', id: @bidding.id, step: '2'
		elsif params[:save_participation]
			redirect_to controller: 'biddings', action: 'edit', id: @bidding.id, step: '3'
		end
	end

	def destroy
		bidding = Bidding.find params[:id]
		if bidding 
			bidding.destroy
			audit = bidding.audits.last
			audit.comment = "Apagou a licitação de id #"+bidding.id.to_s
			audit.save
			gflash :success => "Licitação excluída com sucesso"
		end
		redirect_to biddings_path
	end

	def delete_observation_bidding
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' da licitação de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação excluída com sucesso"
		end
		redirect_to controller: 'biddings', action: 'edit', id: observation.observationtable_id, step: get_step_by_observation(observation.observation_type)
	end


	def delete_observation_bidding_resource
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' da licitação de id #"+observation.observationtable.id.to_s
			audit.save
			resource = BiddingResource.where(id: observation.observationtable_id).first
			if resource
				bidding = Bidding.where(id: resource.bidding_id).first
			end
			gflash :success => "Motivação excluída com sucesso"
		end
		if bidding
			redirect_to controller: 'biddings', action: 'edit', id: bidding.id, step: get_step_by_observation(observation.observation_type)
		else
			redirect_to biddings_path
		end
	end

	def get_step_by_observation(observation_type)
		if observation_type == 1 || observation_type == 2
			return 1
		elsif observation_type == 3
			return 2
		elsif observation_type == 4
			return 3
		else
			return 3
		end
	end

	def delete_phone_bidding
		phone = Phone.find params[:format]
		if phone 
			phone.destroy
			audit = phone.audits.last
			audit.comment = "Apagou o telefone '"+phone.phone+"' da licitação de id #"+phone.phonetable.id.to_s
			audit.save
		end
		redirect_edit_bidding(phone.phonetable_id)
	end

	def delete_email_bidding
		email = Email.find params[:format]
		if email 
			email.destroy
			audit = email.audits.last
			audit.comment = "Apagou o email '"+email.email+"' da licitação de id #"+email.emailtable.id.to_s
			audit.save
		end
		redirect_edit_bidding(email.emailtable_id)
	end

	def delete_skype_bidding
		skype = Skype.find params[:format]
		if skype 
			skype.destroy
			audit = skype.audits.last
			audit.comment = "Apagou o skype '"+skype.skype+"' da licitação de id #"+skype.skypetable.id.to_s
			audit.save
		end
		redirect_edit_bidding(skype.skypetable_id)
	end

	def redirect_edit_bidding(responsible_id)
		responsible = Responsible.find responsible_id
		bidding = responsible.responsibletable_id
		redirect_to edit_bidding_path bidding
	end

	def save_edit_qualifications
		result = false
		if params[:type] && params[:type] != '' && params[:id] && params[:id] != '' && params[:text] && params[:text] != ''
			if params[:type] == '1'
				object = GoodHabit.where(id: params[:id]).first
				if object
					object.update_column(:name, params[:text])
					result = true
				end
			elsif params[:type] == '2'
				object = AccreditationPresential.where(id: params[:id]).first
				if object
					object.update_column(:name, params[:text])
					result = true
				end
			elsif params[:type] == '3'
				object = Habilitation.where(id: params[:id]).first
				if object
					object.update_column(:name, params[:text])
					result = true
				end
			end
		end

		data = {
			:result => result
		}

		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'capture'
				text = Bidding.notification_bidding_catch(@bidding, @current_user)
				action_notification = ActionNotification.find_or_create_by(:name => 'Edição de Licitação (Captura)')
				users_to_notificate = [1,4,11,16,17]
			elsif type == 'read'
				text = Bidding.notification_bidding_read(@bidding, @current_user)
				action_notification = ActionNotification.find_or_create_by(:name => 'Edição de Licitação (Leitura)')
				users_to_notificate = [1,4,11,17]
			elsif type == 'participation'
				text = Bidding.notification_bidding_participation(@bidding, @current_user)
				action_notification = ActionNotification.find_or_create_by(:name => 'Edição de Licitação (Participação)')
				users_to_notificate = [1,4,11]
			end
			already_sent = false
			User.to_create_notification(users_to_notificate).each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification.id
				notification.area_notification_id = 3
				notification.sender = @current_user
				notification.receiver = user
				notification.text = text
				notification.save
				if user.id == @current_user.id
					already_sent = true
				end
			end
			if !already_sent
				# Para o próprio usuário
				notification = Notification.new
				notification.action_notification_id = action_notification.id
				notification.area_notification_id = 3
				notification.sender = @current_user
				notification.receiver = @current_user
				notification.text = text
				notification.save
			end
		end
	end

	private
	def bidding_params
		params.require(:bidding).permit(
			:id,
			:catch_user_id,
			:catch_date_catch,
			:catch_client_id,
			:catch_organ_id,
			:catch_capture_form_id,
			:catch_other_capture_form,
			:catch_cost,
			:catch_bid_newspaper_id,
			:catch_capture_form_presencial_id,
			:catch_solicitation_date_organ,
			:catch_limit_date_organ,
			:catch_organ_notification,
			:catch_organ_notification_observation,
			:catch_modalidate_id,
			:catch_other_modalidate,
			:catch_number,
			:catch_process,
			:catch_portal_id,
			:catch_limit_date,
			:catch_competition_date,
			:catch_suspension_communication_date,
			:catch_reopened_date,
			:catch_publication_date,
			:catch_bidding_id,
			:read_user_id,
			:read_displacement_km,
			:read_displacement,
			:read_agreed_amount,
			:read_date_read,
			:read_sample,
			:read_delivery_time,
			:read_survey,
			:read_deadline,
			:read_judgment_form_id,
			:read_other_judgment_form,
			:read_srp,
			:read_installation,
			:read_catalog,
			:read_product_guarantee,
			:read_proposal_guarantee,
			:read_proposal_guarantee_percent,
			:read_proposal_guarantee_value,
			:read_claritication,
			:read_claritication_deadline,
			:read_claritication_motivation,
			:read_impugnment,
			:read_impugnment_deadline,
			:read_impugnment_motivation,
			:read_bidding_read_delivery_id,
			:read_bidding_read_delivery_deadline,
			:read_exclusive_me_epp,
			:read_guarantee_contractual,
			:read_guarantee_contractual_value,
			:read_guarantee_contractual_percent,
			:read_claritication_solicitation_date,
			:read_impugnment_solicitation_date,
			:good_habit_name_read,
			:accreditation_presential_name_read,
			:habilitation_name_read,
			:good_habit_name_participation,
			:accreditation_presential_name_participation,
			:habilitation_name_participation,
			:participation_return_date,
			:participation_partner_participation_id,
			:participation_partner_participation_justification,
			:participation_process_status_id,
			:participation_process_status_date,
			:participation_resource,
			:participation_against_reason,
			:participation_process_location_id,
			:scheduling_date,
			good_habit_ids: [],
			accreditation_presential_ids: [],
			habilitation_ids: [],
			participation_user_ids: [],
			observations_attributes: [
				:id, 
				:user_id,
				:_destroy,
				:observation,
				:observation_type
				],
				attachments_attributes: [
					:id, 
					:_destroy,
					:attachment,
					:attachment_type
					],
					bidding_responsibles_attributes: [
						:id, 
						:_destroy,
						:user_id,
						:initial_date,
						:final_date
						],
						bidding_proposals_attributes: [
							:id, 
							:_destroy,
							:price_offer_id,
							:another_price_offer,
							:registration_form_id,
							:technical_offer,
							:judgment_form_id,
							:quoted_value,
							:discount_percent,
							:item_number,
							:description,
							:quantity,
							:unitary_value,
							:total_value,
							:global_value,
							:partner_rank_text,
							:partner_rank_id,
							:participation_result_id,
							:competition_status_id,
							:auctioned_value,
							:unit_id,
							:traded_value,
							:bidder_name,
							:representative_name,
							:cnpj,
							:past_due,
							:bidder_status_id,
							:another_bidder_status,
							:provenance_id,
							:country_id,
							:site,
							address_attributes: [
								:id,
								:zipcode,
								:address,
								:district,
								:number, 
								:complement,
								:type,
								:state_id,
								:city_id
								],
								phones_attributes: [
									:id,
									:_destroy,
									:phone
									],
									emails_attributes: [
										:id,
										:_destroy,
										:email
									]
									],
									bidding_resources_attributes: [
										:id,
										:_destroy,
										:bidding_id,
										:bidding_proposal_id,
										:resource_type,
										:initial_date,
										:final_date,
										:insertion_portal_date,
										:result_id,
										attachments_attributes: [
											:id,
											:_destroy,
											:attachment,
											],
											observations_attributes: [
												:id,
												:_destroy,
												:observation,
												:user_id
											]

										]
										)
end
end
