class UsersController < ApplicationController

	skip_before_action :authenticate_user, :only => [:recovery_pass, :create_recovery_pass, :edit_pass, :update_pass]
	before_action :only_admin, :only => [:new, :destroy, :index]

	def index
		@grid = UsersGrid.new(params[:users_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@user = User.new
		@user.phone_users.build
		@user.email_users.build
	end

	def create
		@user = User.new user_params
		if @user.save
			audit = @user.audits.last
			audit.comment = "Criou o usuário '"+@user.name+"' de id #"+@user.id.to_s
			audit.save
			gflash :success => "Usuário cadastrado com sucesso"
			ApplicationMailer.new_user_created_message(@user).deliver_now
			generate_notification('create')
			redirect_to users_path
		else
			build_phone_email_user
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@user.errors.full_messages.join('<br>')
			render 'new'
		end
	end

	def edit
		@user = User.find params[:id]
		@user.phone_users.build
		@user.email_users.build
	end

	def build_phone_email_user
		if @user.phone_users.length == 0
			@user.phone_users.build
		end

		if @user.email_users.length == 0
			@user.email_users.build
		end
	end

	def update
		@user = User.find params[:id]
		@user.skip_validate_password = true
		if @user.update user_params
			audit = @user.audits.last
			audit.comment = "Editou o usuário '"+@user.name+"' de id #"+@user.id.to_s
			audit.save
			gflash :success => "Usuário editado com sucesso"
			generate_notification('update')
			redirect_to users_path
		else
			build_phone_email_user
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@user.errors.full_messages.join('<br>')
			render 'edit'
		end
	end

	def destroy
		@user = User.find params[:id]
		if @user 
			delete_calendar_events
			@user.destroy
			audit = @user.audits.last
			audit.comment = "Apagou o usuário '"+@user.name+"' de id #"+@user.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Usuário excluído com sucesso"
		end
		redirect_to users_path
	end

	def delete_calendar_events
		CalendarEvent.where(:user_id => @user.id).delete_all
	end

	def recovery_pass
	end

	def create_recovery_pass
		user = User.find_by_email params[:email]
		if user 
			if verify_recaptcha(model: user)
				if user.is_admin?
					user.update_column(:recovery_token, SecureRandom.urlsafe_base64)
					ApplicationMailer.recovery_pass_message(user).deliver_now
					gflash :success => "Um link para recuperação de senha foi enviado para o email cadastrado"
					redirect_to new_session_path
				else
					gflash :now, :error => "Usuário não é administrador"
					render 'recovery_pass'
				end
			else
				gflash :now, :error => "ReCaptcha inválido"
				render 'recovery_pass'
			end
		else
			gflash :now, :error => "Email inexistente"
			render 'recovery_pass'
		end
	end

	def edit_pass
		if params[:recovery_token]
			# efetua logoff para evitar de alterar senha do user logado
			session[:user_id] = nil
			session[:client_id] = nil
			@user = User.find_by_recovery_token params[:recovery_token]
		end
		if current_user
			@user = current_user
		end
		if !@user
			gflash :error => "Informe corretamente a nova senha"
			redirect_to :back
		end
	end

	def update_pass
		@user = User.find params[:id]
		@user.edit_pass = true
		if @user.update_attributes(user_params)
			audit = @user.audits.last
			audit.comment = "Alterou a senha"
			audit.save
			gflash :success => "Sua senha foi redefinida"
			# Autentica o user
			session[:user_id] = @user.id
			redirect_to users_path
		else
			gflash :error => @user.errors.full_messages.join('<br>')
			redirect_to :back
		end
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'create'
				text = User.notification_new_user(@user, @current_user)
				action_notification_id = 1
			elsif type == 'update'
				text = User.notification_edit_user(@user, @current_user)
				action_notification_id = 2
			elsif type == 'destroy'
				text = User.notification_delete_user(@user, @current_user)
				action_notification_id = 3
			end
			already_sent = false
			User.to_create_notification([1]).each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 1
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
				notification.area_notification_id = 1
				notification.sender = @current_user
				notification.receiver = @current_user
				notification.text = text
				notification.save
			end
		end
	end

	private
	def user_params
		params.require(:user).permit(
			:name,
			:email,
			:password,
			:password_confirmation,
			:recovery_token,
			:last_access,
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:office,
			:department,
			:rg,
			:cpf,
			:birth_date,
			:whatsapp,
			:skype,
			:is_blocked,
			:state_id, 
			:city_id,
			:office_state_id,
			:office_city_id,
			:profile_id,
			:password_to_save,
			:calendar_color_id,
			permission_profile_ids: [],
			email_users_attributes: [
				:id,
				:email,
				:_destroy
				],
				phone_users_attributes: [
					:id,
					:phone,
					:_destroy
				]

				)
	end
end
