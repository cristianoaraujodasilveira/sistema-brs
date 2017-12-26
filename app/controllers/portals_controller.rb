class PortalsController < ApplicationController

	before_action :register

	def index
		@grid_portals = PortalsGrid.new(params[:portals_grid]) do |scope|
			scope.page(params[:page])
		end
	end

	def new
		@portal = Portal.new
		build_portals
	end

	def edit
		@portal = Portal.find params[:id]
		build_portals
	end

	def build_portals
		if !@portal.address
			@portal.build_address
		end
		if @portal.responsibles.length == 0
			@portal.responsibles.build
		end
		@portal.observations.build
		build_portals_attributes
	end

	def build_portals_attributes
		@portal.responsibles.each do |responsible|
			if responsible.phones.length == 0
				responsible.phones.build
			end
			if responsible.emails.length == 0
				responsible.emails.build
			end
			if responsible.skypes.length == 0
				responsible.skypes.build
			end
		end
	end

	def create
		@portal = Portal.new(portal_params)
		@portal.user_id = @current_user.id
		if params[:add_responsible]
		    # add empty responsible associated with @portal
		    @portal.responsibles.build
		    build_portals
		    render :new
		else
			# save goes like usual
			if @portal.save
				@portal.update_attribute(:user_id, @current_user.id)
				audit = @portal.audits.last
				audit.comment = "Criou o portal '"+@portal.name+"' de id #"+@portal.id.to_s
				audit.save
				gflash :success => "Portal cadastrado com sucesso"
				redirect_to edit_portal_path @portal
			else
				build_portals
				gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@portal.errors.full_messages.join('<br>')
				render :new
			end
		end
	end

	def build_in_edit(portal_params)
		unless portal_params[:responsibles_attributes].blank?
			for attribute in portal_params[:responsibles_attributes]
				@portal.responsibles.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
			end
		end
	end

	def update
		@portal = Portal.find(params[:id])

		if params[:add_responsible]
			build_in_edit(portal_params)
	      	# add one more empty responsible attribute
	      	@portal.responsibles.build
	      	build_portals
	      	render :edit
	      else
	        # save goes like usual
	        if @portal.update_attributes portal_params
	        	audit = @portal.audits.last
	        	if audit
	        		audit.comment = "Editou o portal '"+@portal.name+"' de id #"+@portal.id.to_s
	        		audit.save
	        	else
	        		audit = Audit.last
	        		if audit && audit.comment == nil && audit.auditable_type == 'Portal'
	        			if audit.action == 'create'
	        				text = "Criou"
	        			elsif audit.action == 'update'
	        				text = "Editou"
	        			elsif audit.action == 'destroy'
	        				text = "Apagou"
	        			end
	        			audit.comment = text+" o portal de id #"+audit.auditable_id.to_s
	        			audit.save
	        		end
	        	end
	        	gflash :success => "Portal editado com sucesso"
	        	redirect_to edit_portal_path @portal
	        else
	        	build_portals
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@portal.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		portal = Portal.find params[:id]
		if portal 
			portal.destroy
			audit = portal.audits.last
			audit.comment = "Apagou o portal '"+portal.name+"' de id #"+portal.id.to_s
			audit.save
			gflash :success => "Portal excluído com sucesso"
		end
		redirect_to portals_path
	end

	def delete_observation_portal
		observation = Observation.find params[:format]
		if observation 
			observation.destroy
			audit = observation.audits.last
			audit.comment = "Apagou a observação '"+observation.observation+"' do portal '"+observation.observationtable.name+"' de id #"+observation.observationtable.id.to_s
			audit.save
			gflash :success => "Observação excluída com sucesso"
		end
		redirect_to edit_portal_path observation.observationtable_id
	end

	def delete_phone_portal
		phone = Phone.find params[:format]
		if phone 
			phone.destroy
			audit = phone.audits.last
			audit.comment = "Apagou o telefone '"+phone.phone+"' do portal '"+phone.phonetable.name+"' de id #"+phone.phonetable.id.to_s
			audit.save
		end
		redirect_edit_portal(phone.phonetable_id)
	end

	def delete_email_portal
		email = Email.find params[:format]
		if email 
			email.destroy
			audit = email.audits.last
			audit.comment = "Apagou o email '"+email.email+"' do portal '"+email.emailtable.name+"' de id #"+email.emailtable.id.to_s
			audit.save
		end
		redirect_edit_portal(email.emailtable_id)
	end

	def delete_skype_portal
		skype = Skype.find params[:format]
		if skype 
			skype.destroy
			audit = skype.audits.last
			audit.comment = "Apagou o skype '"+skype.skype+"' do portal '"+skype.skypetable.name+"' de id #"+skype.skypetable.id.to_s
			audit.save
		end
		redirect_edit_portal(skype.skypetable_id)
	end

	def redirect_edit_portal(responsible_id)
		responsible = Responsible.find responsible_id
		portal = responsible.responsibletable_id
		redirect_to edit_portal_path portal
	end

	private
	def portal_params
		params.require(:portal).permit(
			:id,
			:user_id,
			:client_id,
			:name,
			:initial_date,
			:final_date,
			:site,
			:phone,
			:email,
			:responsible,
			:registration_unit,
			responsibles_attributes: [
				:id,
				:_destroy,
				:name,
				:office,
				:department,
				:phone,
				:email,
				:skype,
				:whatsapp,
				:type,
				phones_attributes: [
					:_destroy,
					:id,
					:phone
					],
					emails_attributes: [
						:_destroy,
						:id,
						:email
						],
						skypes_attributes: [
							:_destroy,
							:id,
							:skype
						]
						],
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
							observations_attributes: [
								:id, 
								:user_id,
								:_destroy,
								:observation
							]
							)
	end
end
