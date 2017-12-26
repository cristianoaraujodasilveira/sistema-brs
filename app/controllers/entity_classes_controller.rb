class EntityClassesController < ApplicationController
	
	before_action :commercial

	def index
		@grid_entity_classes = EntityClassesGrid.new(params[:entity_classes_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def edit
		@entity_class = EntityClass.find params[:id]
		build_entity_class_responsibles_attributes
	end

	def new
		@entity_class = EntityClass.new
		build_entity_class_responsibles_attributes
	end

	def create
		@entity_class = EntityClass.new(entity_class_params)
		if params[:add_responsible]
			@entity_class.entity_class_responsibles.build
			build_entity_class_responsibles_attributes
			render :new
		elsif params[:remove_data]
			build_entity_class_responsibles_attributes
			render :new
		else
			if @entity_class.save
				audit = @entity_class.audits.last
				audit.comment = "Criou o entidade de classe '"+@entity_class.name+"' de id #"+@entity_class.id.to_s
				audit.save
				gflash :success => "Entidade de classe cadastrada com sucesso"
				generate_notification('create')
				redirect_to entity_classes_path
			else
				build_entity_class_responsibles_attributes
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@entity_class.errors.full_messages.join('<br>')
				render :new
			end
		end
	end

	def build_entity_class_responsibles_attributes
		if @entity_class.entity_class_responsibles.length == 0
			@entity_class.entity_class_responsibles.build
		end
		@entity_class.entity_class_responsibles.each do |sector|
			sector.phone_users.build
			sector.email_users.build
		end
	end

	def update
		@entity_class = EntityClass.find(params[:id])

		if params[:add_responsible]
			unless entity_class_params[:entity_class_responsibles_attributes].blank?
				for attribute in entity_class_params[:entity_class_responsibles_attributes]
					@entity_class.entity_class_responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
				end
			end
			@entity_class.entity_class_responsibles.build
			build_entity_class_responsibles_attributes
			render :edit
		elsif params[:remove_data]
			build_entity_class_responsibles_attributes
			render :edit
		else
			if @entity_class.update_attributes entity_class_params
				audit = @entity_class.audits.last
				if audit
					audit.comment = "Editou a entidade de classe '"+@entity_class.name+"' de id #"+@entity_class.id.to_s
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
						audit.comment = text+" o setor de id #"+audit.auditable_id.to_s+" do orgão de id #"+@entity_class.id.to_s
						audit.save
					end
				end
				generate_notification('update')
				gflash :success => "Entidade de classe editada com sucesso"
				redirect_to edit_entity_class_path @entity_class
			else
				build_entity_class_responsibles_attributes
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@entity_class.errors.full_messages.join('<br>')
				render :edit
			end
		end
	end

	def destroy
		@entity_class = EntityClass.find params[:id]
		if @entity_class 
			calendar_events = CalendarEvent.where(:entity_class_id => @entity_class.id).update_all(:entity_class_id => nil)
			@entity_class.destroy
			audit = @entity_class.audits.last
			audit.comment = "Apagou a entidade de classe '"+@entity_class.name+"' de id #"+@entity_class.id.to_s
			audit.save
			generate_notification('destroy')
			gflash :success => "Entidade de classe excluída com sucesso"
		end
		redirect_to entity_classes_path
	end

	def generate_notification(type)
		if @current_user.id != 1
			if type == 'create'
				text = EntityClass.notification_new_entity_class(@entity_class, @current_user)
				action_notification_id = 13
			elsif type == 'update'
				text = EntityClass.notification_edit_entity_class(@entity_class, @current_user)
				action_notification_id = 14
			elsif type == 'destroy'
				text = EntityClass.notification_delete_entity_class(@entity_class, @current_user)
				action_notification_id = 15
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
	def entity_class_params
		params.require(:entity_class).permit(
			:id,
			:name,
			:description,
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:state_id, 
			:city_id,
			entity_class_responsibles_attributes: [
				:id,
				:name,
				:office,
				:department,
				:whatsapp,
				:skype,
				:_destroy,
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
				]
				)
	end
end
