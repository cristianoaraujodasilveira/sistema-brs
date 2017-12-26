class CalendarEventsController < ApplicationController

	def index
		if params[:calendar_events_grid] != nil
			if params[:calendar_events_grid][:name] == "" && params[:calendar_events_grid][:initial_date][0] == "" && params[:calendar_events_grid][:initial_date][1] == ""
				params[:calendar_events_grid][:initial_date][0] = Time.now.beginning_of_week
				params[:calendar_events_grid][:initial_date][1] = Time.now.end_of_week
			end
			@grid = CalendarEventsGrid.new(params[:calendar_events_grid])
			@grid_visits = VisitsReportsCalendarGrid.new(params[:calendar_events_grid])
		else
			initial_date = Time.now.beginning_of_week
			final_date = Time.now.end_of_week
			@grid = CalendarEventsGrid.new(params[:calendar_events_grid]) do |scope|
				scope.where("initial_date >= '#{initial_date} 00:00:00' AND initial_date <= '#{final_date} 23:59:59'")
			end
			@grid_visits = VisitsReportsCalendarGrid.new(params[:calendar_events_grid]) do |scope|
				scope.where("visits_reports.date_and_time >= '#{initial_date} 00:00:00' AND visits_reports.date_and_time <= '#{final_date} 23:59:59'")
			end
		end
		
		@total_values = @grid.assets + @grid_visits.assets
	end

	def new
		@calendar_event = CalendarEvent.new
		if params[:start] && params[:end]
			date_start = Time.at(params[:start].to_f/1000).utc
			date_end = Time.at(params[:end].to_f/1000).utc
			@calendar_event.initial_date = DateTime.new(date_start.strftime('%Y').to_i, date_start.strftime('%m').to_i, date_start.strftime('%d').to_i)
			@calendar_event.initial_time = Time.new(date_start.strftime('%Y').to_i, date_start.strftime('%m').to_i, date_start.strftime('%d').to_i, date_start.strftime('%H').to_i, date_start.strftime('%M').to_i);
			@calendar_event.final_time = Time.new(date_end.strftime('%Y').to_i, date_end.strftime('%m').to_i, date_end.strftime('%d').to_i, date_end.strftime('%H').to_i, date_end.strftime('%M').to_i);
		end
	end

	def edit
		@calendar_event = CalendarEvent.find params[:id]
	end

	def create
		@calendar_event = CalendarEvent.new calendar_event_params
		if @calendar_event.user_id == nil || @calendar_event.user_id == ''
			@calendar_event.user = @current_user
		end
		if @calendar_event.save
			generate_replicated_events
			generate_replicated_events_shared
			audit = @calendar_event.audits.last
			audit.comment = "Criou o evento '"+@calendar_event.name+"' de id #"+@calendar_event.id.to_s
			audit.save
			gflash :success => "Evento cadastrado com sucesso"
			redirect_to calendar_events_path
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@calendar_event.errors.full_messages.join('<br>')
			render 'new'
		end
	end

	def update
		@calendar_event = CalendarEvent.find params[:id]
		if @calendar_event.user_id == nil || @calendar_event.user_id == ''
			@calendar_event.user = @current_user
		end
		if @calendar_event.update calendar_event_params
			destroy_replicated_events
			generate_replicated_events
			generate_replicated_events_shared
			audit = @calendar_event.audits.last
			audit.comment = "Editou o evento '"+@calendar_event.name+"' de id #"+@calendar_event.id.to_s
			audit.save
			gflash :success => "Evento editado com sucesso"
			redirect_to calendar_events_path
		else
			gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@calendar_event.errors.full_messages.join('<br>')
			render 'edit'
		end
	end

	def events_marked
		data = nil
		if params[:user_id] != nil && params[:user_id] != '0'
			data = CalendarEvent.includes(:calendar_color).includes(:user).includes(user: :calendar_color).where(user_id: params[:user_id])
		else
			data = CalendarEvent.includes(:calendar_color).includes(:user).includes(user: :calendar_color).where.not(:initial_date => nil)
		end
		respond_to do |format|
			format.html { render 'index'}
			format.json {render :json => data, :status => 200}
		end
	end

	def destroy_replicated_events
		replicateds = CalendarEvent.where(:calendar_event_id => @calendar_event.id)
		if replicateds && replicateds.length > 0
			replicateds.destroy_all
		end
	end

	def generate_replicated_events
		if @calendar_event.repeat
			if !@calendar_event.calendar_repetition
				replicate_daily_or_weekly(1,(@calendar_event.quantity_repetition-1))
			elsif @calendar_event.calendar_repetition_id == 1
				replicate_daily_or_weekly(1,1)
			elsif @calendar_event.calendar_repetition_id == 2 
				replicate_daily_or_weekly(1,(@calendar_event.quantity_repetition-1))
			elsif @calendar_event.calendar_repetition_id == 3
				replicate_daily_or_weekly(7,(@calendar_event.quantity_repetition-1))
			elsif @calendar_event.calendar_repetition_id == 4 
				replicate_monthly((@calendar_event.quantity_repetition-1))
			elsif @calendar_event.calendar_repetition_id == 5 
				replicate_annually((@calendar_event.quantity_repetition-1))
			elsif @calendar_event.calendar_repetition_id == 6
				replicate_by_weekday(@calendar_event.quantity_repetition)
			else
				replicate_daily_or_weekly(1,1)
			end
		end
	end

	def replicate_daily_or_weekly(distance, quantity)
		initial_date = @calendar_event.initial_date
		for i in 1..quantity
			calendar_event = CalendarEvent.new(@calendar_event.attributes)
			calendar_event.id = nil
			calendar_event.calendar_event_id = @calendar_event.id
			calendar_event.initial_date = initial_date+distance.days
			calendar_event.save
			initial_date = calendar_event.initial_date
		end
	end

	def replicate_monthly(quantity)
		initial_date = @calendar_event.initial_date
		for i in 1..quantity
			calendar_event = CalendarEvent.new(@calendar_event.attributes)
			calendar_event.id = nil
			calendar_event.calendar_event_id = @calendar_event.id
			if initial_date.strftime("%d").to_i > 28
				current_date = get_next_date(initial_date, i, 0)
			else
				current_date = initial_date + i.month
			end
			calendar_event.initial_date = current_date
			calendar_event.save
		end	
	end

	def replicate_annually(quantity)
		initial_date = @calendar_event.initial_date
		for i in 1..quantity
			calendar_event = CalendarEvent.new(@calendar_event.attributes)
			calendar_event.id = nil
			calendar_event.calendar_event_id = @calendar_event.id
			calendar_event.initial_date = initial_date+1.year
			calendar_event.save
			initial_date = calendar_event.initial_date
		end
	end

	def replicate_by_weekday(quantity)
		weekdays = @calendar_event.weekdays.sort_by{|e| e[:value]}
		weekday_current = @calendar_event.initial_date.wday
		last_calendar_event = @calendar_event
		for i in 1..quantity
			if i == 1
				weekdays.each do |wd|
					if wd.value > weekday_current
						distance = wd.value - weekday_current
						calendar_event = CalendarEvent.new(@calendar_event.attributes)
						calendar_event.id = nil
						calendar_event.calendar_event_id = @calendar_event.id
						calendar_event.initial_date = @calendar_event.initial_date+distance.days
						calendar_event.save
						last_calendar_event = calendar_event
					end
				end
				if last_calendar_event.initial_date.wday != 0
					last_calendar_event.initial_date = last_calendar_event.initial_date + (7-last_calendar_event.initial_date.wday).days
				end
			else
				weekday_current = last_calendar_event.initial_date.wday
				weekdays.each do |wd|
					if wd.value >= weekday_current
						distance = wd.value - weekday_current
						calendar_event = CalendarEvent.new(@calendar_event.attributes)
						calendar_event.id = nil
						calendar_event.calendar_event_id = @calendar_event.id
						calendar_event.initial_date = last_calendar_event.initial_date+distance.days
						calendar_event.save
						last_calendar_event = calendar_event
						weekday_current = last_calendar_event.initial_date.wday
					end
				end
				if last_calendar_event.initial_date.wday != 0
					last_calendar_event.initial_date = last_calendar_event.initial_date + (7-last_calendar_event.initial_date.wday).days
				end
			end
		end
	end

	def get_next_date(initial_date, current_month, day)
		next_date = initial_date + current_month.month + day.day
		if next_date.strftime("%d") == initial_date.strftime("%d") || next_date.strftime("%m") != initial_date.strftime("%m")
			return next_date - day.day
		else
			get_next_date(initial_date, 0, 1)
		end
	end

	def generate_replicated_events_shared
		if @calendar_event.shared && @calendar_event.users.length > 0
			replicated_events = CalendarEvent.where(:calendar_event_id => @calendar_event.id)
			puts replicated_events.length.to_s
			@calendar_event.users.each do |user|
				calendar_event = CalendarEvent.new(@calendar_event.attributes)
				calendar_event.id = nil
				calendar_event.user_id = user.id
				calendar_event.calendar_event_id = @calendar_event.id
				calendar_event.save
				if replicated_events && replicated_events.length > 0
					replicated_events.each do |event|
						calendar_event = CalendarEvent.new(event.attributes)
						calendar_event.id = nil
						calendar_event.user_id = user.id
						calendar_event.calendar_event_id = @calendar_event.id
						calendar_event.save
					end
				end
			end
		end
	end

	def destroy
		calendar_event = CalendarEvent.find params[:id]
		if calendar_event 
			replicateds = CalendarEvent.where(:calendar_event_id => calendar_event.id)
			if replicateds && replicateds.length > 0
				replicateds.destroy_all
			end
			calendar_event.destroy
			audit = calendar_event.audits.last
			audit.comment = "Apagou o evento '"+calendar_event.name+"' de id #"+calendar_event.id.to_s
			audit.save
			gflash :success => "Evento excluído com sucesso"
		end
		redirect_to calendar_events_path
	end

	private
	def calendar_event_params
		params.require(:calendar_event).permit(
			:id,
			:entity_class_id,
			:name,
			:user_id,
			:calendar_color_id,
			:calendar_type_event_id,
			:shared,
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:state_id, 
			:city_id,
			:quantity_repetition,
			:send_notification,
			:repeat,
			:calendar_repetition_id,
			:observation,
			:initial_date,
			:initial_time,
			:final_time,
			:weekday_ids => [],
			:user_ids => []
			)
	end

end