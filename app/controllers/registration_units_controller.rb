class RegistrationUnitsController < ApplicationController

	before_action :register

	def index
		@grid_registration_units = RegistrationUnitsGrid.new(params[:registration_units_grid]) do |scope|
			scope.page(params[:page])
		end
		registration_unit_id = params[:format]
		if registration_unit_id
			@registration_unit = RegistrationUnit.find registration_unit_id
			@show_grid_responsible = true
			@grid_responsible_registration_units = ResponsibleRegistrationUnitsGrid.new(params[:responsible_registration_units_grid]) do |scope|
				scope.where(:registration_unit_id => registration_unit_id.to_i).page(params[:page])	
			end
		else
			@show_grid_responsible_registration_unit = false
			@grid_responsible_registration_units = ResponsibleRegistrationUnitsGrid.new(params[:responsible_registration_units_grid]) do |scope|
				scope.page(params[:page])	
			end
		end
	end

	def edit
		@registration_unit = RegistrationUnit.find params[:id]
		@registration_unit.responsible_registration_units.build
		build_responsible_registration_units_attributes
	    build_registration_units_attributes
	end

	def new
		@registration_unit = RegistrationUnit.new
		@registration_unit.responsible_registration_units.build
		build_responsible_registration_units_attributes
		build_registration_units_attributes
	end

	def create
		@registration_unit = RegistrationUnit.new(registration_unit_params)
		if params[:add_unit]
		    # add empty registration_unit associated with @registration_unit
		    @registration_unit.registration_units.build
		    build_responsible_registration_units_attributes
		    build_registration_units_attributes
		    render :new
		elsif params[:add_responsible_registration_unit]
			@registration_unit.responsible_registration_units.build
			build_registration_units_attributes
			build_responsible_registration_units_attributes
			render :new
		elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_responsible_registration_units_attributes
		    build_registration_units_attributes
		    render :new
		else
	        # save goes like usual
	        if @registration_unit.save
	        	audit = @registration_unit.audits.last
	        	audit.comment = "Criou a unidade de cadastramento '"+@registration_unit.name+"' de id #"+@registration_unit.id.to_s
	        	audit.save
	        	gflash :success => "Unidade de cadastramento cadastrada com sucesso"
	        	redirect_to registration_units_path
	        else
	        	build_responsible_registration_units_attributes
	        	build_registration_units_attributes
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@registration_unit.errors.full_messages.join('<br>')
	        	render :new
	        end
	    end
	end

	def build_responsible_registration_units_attributes
		@registration_unit.responsible_registration_units.each do |responsible|
			responsible.phone_users.build
			responsible.email_users.build
		end
	end

	def build_registration_units_attributes
		@registration_unit.registration_units.each do |registration|
			registration.phone_users.build
			registration.email_users.build
		end
		@registration_unit.phone_users.build
		@registration_unit.email_users.build
	end

	def update
		@registration_unit = RegistrationUnit.find(params[:id])

		if params[:add_unit]
			# rebuild the registration_units attributes that doesn't have an id
			unless registration_unit_params[:registration_units_attributes].blank?
				for attribute in registration_unit_params[:registration_units_attributes]
					@registration_unit.registration_units.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
				end
			end
	      	# add one more empty registration_unit attribute
	      	@registration_unit.registration_units.build
	      	build_responsible_registration_units_attributes
	      	build_registration_units_attributes
	      	render :edit
	      elsif params[:add_responsible_registration_unit]
	      	unless registration_unit_params[:responsible_registration_units_attributes].blank?
	      		for attribute in registration_unit_params[:responsible_registration_units_attributes]
	      			@registration_unit.responsible_registration_units.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	      		end
	      	end
	      	# add one more empty sector attribute
	      	@registration_unit.responsible_registration_units.build
	      	build_responsible_registration_units_attributes
	      	build_registration_units_attributes
	      	render :edit
	      elsif params[:remove_data]
		    # nested model that have _destroy attribute = 1 automatically deleted by rails
		    build_responsible_registration_units_attributes
		    build_registration_units_attributes
		    render :edit
		else
	        # save goes like usual
	        if @registration_unit.update_attributes registration_unit_params
	        	audit = @registration_unit.audits.last
	        	if audit
	        		audit.comment = "Editou a unidade de cadastramento '"+@registration_unit.name+"' de id #"+@registration_unit.id.to_s
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
	        			audit.comment = text+" o responsável de id #"+audit.auditable_id.to_s+" da unidade de cadastramento de id #"+@registration_unit.id.to_s
	        			audit.save
	        		end
	        	end
	        	gflash :success => "Unidade de cadastramento editada com sucesso"
	        	redirect_to edit_registration_unit_path @registration_unit
	        else
	        	build_responsible_registration_units_attributes
	        	build_registration_units_attributes
	        	gflash :now, :error => "Preencha os campos obrigatórios para conseguir salvar!<br><br>"+@registration_unit.errors.full_messages.join('<br>')
	        	render :edit
	        end
	    end
	end

	def destroy
		registration_unit = RegistrationUnit.find params[:id]
		if registration_unit 
			registration_unit.destroy
			audit = registration_unit.audits.last
			audit.comment = "Apagou a unidade de cadastramento '"+registration_unit.name+"' de id #"+registration_unit.id.to_s
			audit.save
			gflash :success => "Unidade de cadastramento excluída com sucesso"
		end
		redirect_to registration_units_path
	end

	def delete_responsible_registration_unit
		responsible_registration_unit = ResponsibleRegistrationUnit.find params[:format]
		if responsible_registration_unit 
			responsible_registration_unit.destroy
			audit = responsible_registration_unit.audits.last
			audit.comment = "Apagou o responsável '"+responsible_registration_unit.name+"' de id #"+responsible_registration_unit.id.to_s+" da unidade de cadastramento de id #"+responsible_registration_unit.registration_unit_id.to_s
			audit.save
			gflash :success => "Responsável excluído com sucesso"
		end
		redirect_to :back
	end

	private
	def registration_unit_params
		params.require(:registration_unit).permit(
			:organ_id,
			:name,
			:site,
			:zipcode,
			:address,
			:district,
			:number,
			:complement,
			:state_id, 
			:city_id,
			email_users_attributes: [
				:id,
				:email,
				:_destroy
			],
			phone_users_attributes: [
				:id,
				:phone,
				:_destroy
			],
			responsible_registration_units_attributes: [
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
			],
			registration_units_attributes: [
				:organ_id,
				:name,
				:site,
				:zipcode,
				:address,
				:district,
				:number,
				:complement,
				:state_id, 
				:city_id,
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
