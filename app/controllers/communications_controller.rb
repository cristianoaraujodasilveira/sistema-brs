class CommunicationsController < ApplicationController

	def index
		@grid = CommunicationsGrid.new(params[:communications_grid])
		respond_to do |f|
			f.html do
				if @current_user.is_admin? 
					@grid.scope {|scope| scope.page(params[:page]) }
				else
					@grid.scope {|scope| scope.joins(:communications_users).where(communications_users: { user_id: @current_user.id }).page(params[:page]) }
				end
			end
			f.csv do
				send_data @grid.to_csv(col_sep: ";").encode("ISO-8859-1"),
				type: "text/csv", 
				disposition: 'inline', 
				filename: "Comunicação_Interna-#{Time.now.to_s}.csv"
			end
		end
	end

	def new
		@communication = Communication.new
		build_initials_relations
	end

	def build_initials_relations
		if @communication.attachments.select{|item| item[:id] == nil}.length == 0
			@communication.attachments.build
		end
		if @communication.observations.select{|item| item[:id] == nil}.length == 0
			@communication.observations.build
		end
	end

	def build_in_create(params)
		if params[:add_phone]
			@communication.phones.build
		elsif params[:add_email]
			@communication.emails.build
		end
		build_initials_relations
		render :new
	end

	def create
		@communication = Communication.new communication_params
		@communication.user = @current_user
		if @communication.save
			audit = @communication.audits.last
			audit.comment = "Cadastrou a comunicação interna '"+@communication.subject+"' de id #"+@communication.id.to_s
			audit.save
			gflash :success => "Comunicação interna cadastrado com sucesso"
			communication_by_save_button(params)
			redirect_to edit_communication_path @communication
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@communication.errors.full_messages.join('<br>')
			build_initials_relations
			render :new
		end
	end

	def edit
		@communication = Communication.find params[:id]
		build_initials_relations
	end

	def update
		@communication = Communication.find params[:id]
		if params[:communication_params] || params[:end_call] || params[:save]
			if @communication.update communication_params
				audit = @communication.audits.last
				if audit
					audit.comment = "Editou a comunicação interna de assunto '"+@communication.subject+"' de id #"+@communication.id.to_s
					audit.save
				else
					audit = Audit.last
					if audit && audit.comment == nil && audit.auditable_type == 'communication'
						if audit.action == 'create'
							text = "Criou"
						elsif audit.action == 'update'
							text = "Editou"
						elsif audit.action == 'destroy'
							text = "Apagou"
						end
						audit.comment = text+" a comunicação interna de assunto '"+@communication.subject+"' de id #"+audit.auditable_id.to_s
						audit.save
					end
				end
				communication_by_save_button(params)
				if params[:end_call]
					gflash :success => "Comunicação interna finalizada com sucesso"
				else
					gflash :success => "Comunicação interna editada com sucesso"
				end
				redirect_to edit_communication_path @communication
			else
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@communication.errors.full_messages.join('<br>')
				build_initials_relations
				render :edit
			end
		else
			gflash :success => "Comunicação interna reaberta com sucesso"
			communication_by_save_button(params)
			redirect_to edit_communication_path @communication
		end
	end

	def destroy
		@communication = Communication.find params[:id]
		if @communication 
			@communication.destroy
			audit = @communication.audits.last
			audit.comment = "Apagou a comunicação interna '"+@communication.subject+"' de id #"+@communication.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Comunicação interna excluída com sucesso"
		end
		redirect_to communications_path
	end

	def delete_attachment_communication
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

	def delete_observation_communication
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a resposta '"+observation.observation+"' do comunicação de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Resposta de comunicação excluída com sucesso"
		end
		redirect_to edit_communication_path observation.observationtable_id
	end

	def communication_by_save_button(params)
		if params[:save] || params[:waiting_answer] || params[:reopen_call]
			if params[:waiting_answer]
				generate_notification('create')
			elsif params[:save]
				generate_notification('update')
			elsif params[:reopen_call]
				generate_notification('reopen')
			end
			@communication.update_column(:communication_status_id, 1)
		else
			generate_notification('end')
			@communication.update_column(:communication_status_id, 2)
		end
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'create'
				text = Communication.notification_new_communication(@communication, @current_user)
				action_notification_id = 16
			elsif type == 'update'
				text = Communication.notification_edit_communication(@communication, @current_user)
				action_notification_id = 17
			elsif type == 'destroy'
				text = Communication.notification_delete_communication(@communication, @current_user)
				action_notification_id = 18
			elsif type == 'end'
				text = Communication.notification_end_communication(@communication, @current_user)
				action_notification_id = 19
			elsif type == 'reopen'
				text = Communication.notification_reopen_communication(@communication, @current_user)
				action_notification_id = 20
			end
			already_sent = false
			@communication.communications_users.each do |user|
				if @current_user.id != user.id
					notification = Notification.new
					notification.action_notification_id = action_notification_id
					notification.area_notification_id = 9
					notification.sender = @current_user
					notification.receiver = user
					notification.text = text
					notification.save
					if user.id == @current_user.id
						already_sent = true
					end
				end
			end
			if @current_user.id != @communication.user.id
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 9
				notification.sender = @current_user
				notification.receiver = @communication.user
				notification.text = text
				notification.save
			end
			User.to_create_notification([1]).each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 9
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
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 9
				notification.sender = @current_user
				notification.receiver = @current_user
				notification.text = text
				notification.save
			end
		end
	end

	private
	def communication_params
		params.require(:communication).permit(
			:id,
			:user_id,
			:communication_status_id,
			:department_notified_id,
			:client_id,
			:organ_id,
			:modalidate_id,
			:subject,
			:description,
			:modalidate_number,
			:communications_user_ids => [],
			attachments_attributes: [
				:id,
				:attachment,
				:attachment_type
				],
				observations_attributes:[
					:id,
					:user_id,
					:observation,
					:observation_type,
					:_destroy
					],

					)
	end
end
