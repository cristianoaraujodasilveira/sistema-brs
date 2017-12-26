class VisitsReportsController < ApplicationController

	before_action :commercial

	def index
		@grid_visits_reports = VisitsReportsGrid.new(params[:visits_reports_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def edit
		@visits_report = VisitsReport.find params[:id]
	end

	def new
		@visits_report = VisitsReport.new
	end

	def create
		@visits_report = VisitsReport.new(visits_report_params)
		if @visits_report.save
			audit = @visits_report.audits.last
			audit.comment = "Criou o relatório da visita de id #"+@visits_report.id.to_s
			audit.save
			gflash :success => "Relatório da visita cadastrada com sucesso"
			generate_notification('create')
			redirect_to visits_reports_path
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@visits_report.errors.full_messages.join('<br>')
			render :new
		end
	end

	def update
		@visits_report = VisitsReport.find(params[:id])
		if @visits_report.update_attributes visits_report_params
			audit = @visits_report.audits.last
			if audit
				audit.comment = "Editou o relatório da visita de id #"+@visits_report.id.to_s
				audit.save
			end
			gflash :success => "Relatório da visita editada com sucesso"
			generate_notification('update')
			redirect_to edit_visits_report_path @visits_report
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@visits_report.errors.full_messages.join('<br>')
			render :edit
		end
	end

	def destroy
		@visits_report = VisitsReport.find params[:id]
		if @visits_report 
			proposals = Proposal.where(:visits_report_id => @visits_report.id)
			if proposals && proposals.length > 0
				proposals.destroy_all
			end
			@visits_report.destroy
			audit = @visits_report.audits.last
			audit.comment = "Apagou o relatório da visita de id #"+@visits_report.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Relatório da visita excluído com sucesso"
		end
		redirect_to visits_reports_path
	end

	def visits_report_marked
		data = nil
		if params[:user_id] != nil && params[:user_id] != '0'
			data = VisitsReport.includes(:user).includes(user: :calendar_color).where(user_id: params[:user_id]).where(:shared => true)
		else
			data = VisitsReport.includes(:user).includes(user: :calendar_color).where(:shared => true)
		end
		respond_to do |format|
			format.html { render 'index'}
			format.json {render :json => data, :status => 200}
		end
	end

	def get_informations
		data = VisitsReport.where('id = ?', params[:id]).first
		respond_to do |format|
			format.json {render :json => data, :status => 200}
		end
	end

	def get_visits_reports_values_to_graphic
		users = User.where(:profile_id => [1,3])
		values = Array.new;
		users.each do |user|
			visits_reports = VisitsReport.where(:user_id => user.id).count
			data = {
				:name => user.name,
				:y => visits_reports,
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
				text = VisitsReport.notification_new_visits_report(@visits_report, @current_user)
				action_notification_id = 4
			elsif type == 'update'
				text = VisitsReport.notification_edit_visits_report(@visits_report, @current_user)
				action_notification_id = 5
			elsif type == 'destroy'
				text = VisitsReport.notification_delete_visits_report(@visits_report, @current_user)
				action_notification_id = 6
			end
			already_sent = false
			User.to_create_notification([1,7,8]).each do |user|
				notification = Notification.new
				notification.action_notification_id = action_notification_id
				notification.area_notification_id = 2
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
				notification.area_notification_id = 2
				notification.sender = @current_user
				notification.receiver = @current_user
				notification.text = text
				notification.save
			end
		end
	end

	private
	def visits_report_params
		params.require(:visits_report).permit(
			:id,
			:client_id,
			:social_name,
			:fantasy_name,
			:date_and_time,
			:scale_id,
			:subject,
			:proposal_id,
			:proposal_text,
			:site,
			:responsible_name,
			:intermediary,
			:contacts,
			:phone,
			:email,
			:segment,
			:cnpj,
			:products_and_services,
			:bid_participant,
			:participate_brs,
			:observation,
			:user_id, 
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:shared,
			:state_id,
			:city_id,
			:lat,
			:lng
			)
	end
end
