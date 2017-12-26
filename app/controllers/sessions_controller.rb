class SessionsController < ApplicationController

	skip_before_action :authenticate_user

	def active
		render_session_status
	end
	
	def timeout
		if $user_logged_to_logout 
			user = User.find $user_logged_to_logout.id.to_i
			user.save_date_logout
			$user_logged_to_logout = nil
		end
		render_session_timeout
	end

	def new
		if session[:user_id] != nil
			redirect_to users_path
		end
	end

	def create
		user = User.find_by_email params[:email]

		if user && user.authenticate(params[:password])
			if user.is_blocked
				gflash :now, :error => "Usuário bloqueado"
				render "new"
			else
				session[:user_id] = user.id
				session[:user_logout_id] = user.id
				user.save_date_access
				gflash :success => "Bem vindo!"
				if user.is_admin?
					redirect_to calendar_events_path
				else
					redirect_to users_path
				end
			end
		else
			gflash :now, :error => "Usuário não encontrado"
			render "new"
		end
	end

	def destroy
		user = User.find session[:user_id].to_i
		user.save_date_logout
		session[:user_id] = nil
		$user_logged_to_logout = nil
		gflash :success => "Até logo!"
		redirect_to new_session_path
	end

end
